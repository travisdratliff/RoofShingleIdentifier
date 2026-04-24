//
//  CameraVIew.swift
//  RoofShingleIdentifier
//
//  Created by Travis Domenic Ratliff on 4/24/26.
//

import SwiftUI

struct CameraView: View {
    @State private var camera = CameraModel()
    var body: some View {
        ZStack {
            if camera.isRunning {
                CameraPreviewView(session: camera.session)
                    .ignoresSafeArea()
            }
            
            if let error = camera.error {
                errorView(error)
            }
        }
        .task {
            await camera.start()
        }
        // Stop session when view disappears to free resources
        .onDisappear {
            Task { await camera.stop() }
        }
    }
    
    @ViewBuilder
    private func errorView(_ error: CameraError) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "camera.slash")
                .font(.largeTitle)
            Text(error.localizedDescription)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(.white)
        .padding()
    }
}

//#Preview {
//    CameraVIew()
//}
