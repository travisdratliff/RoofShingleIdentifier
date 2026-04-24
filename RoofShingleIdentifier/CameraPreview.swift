//
//  CameraPreview.swift
//  RoofShingleIdentifier
//
//  Created by Travis Domenic Ratliff on 4/24/26.
//

import SwiftUI
import AVFoundation

// MARK: - Observable Camera Model
@MainActor
@Observable
class CameraModel {
    var isRunning = false
    var error: CameraError?
    
    private(set) var session = AVCaptureSession()
    
    func start() async {
        guard await requestPermission() else {
            error = .permissionDenied
            return
        }
        
        do {
            try setupSession()
            await startSession()
        } catch {
            self.error = .setupFailed(error)
        }
    }
    
    func stop() async {
        await Task.detached(priority: .userInitiated) {
            await self.session.stopRunning()
        }.value
        isRunning = false
    }
    
    // MARK: - Private
    private func requestPermission() async -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return true
        case .notDetermined:
            return await AVCaptureDevice.requestAccess(for: .video)
        default:
            return false
        }
    }
    
    private func setupSession() throws {
        session.beginConfiguration()
        session.sessionPreset = .high
        
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            throw CameraError.noCamera
        }
        
        let input = try AVCaptureDeviceInput(device: camera)
        
        guard session.canAddInput(input) else {
            throw CameraError.setupFailed(nil)
        }
        
        session.addInput(input)
        session.commitConfiguration()
    }
    
    private func startSession() async {
        await Task.detached(priority: .userInitiated) {
            await self.session.startRunning()
        }.value
        isRunning = true
    }
}

enum CameraError: Error {
    case permissionDenied
    case noCamera
    case setupFailed(Error?)
}

struct CameraPreviewView: UIViewRepresentable {
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> PreviewUIView {
        let view = PreviewUIView()
        view.previewLayer.session = session
        view.previewLayer.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIView(_ uiView: PreviewUIView, context: Context) {}
}

class PreviewUIView: UIView {
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
    
    var previewLayer: AVCaptureVideoPreviewLayer {
        layer as! AVCaptureVideoPreviewLayer
    }
}
