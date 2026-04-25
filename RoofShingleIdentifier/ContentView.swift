//
//  ContentView.swift
//  RoofShingleIdentifier
//
//  Created by Travis Domenic Ratliff on 4/23/26.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    //
    @State var camera = CameraManager()
    @State var captureSession: AVCaptureSession?
    @State var selectedTab = 1
    //
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("", systemImage: "camera", value: 1) {
                VStack {
                    ZStack {
                        if camera.permissionGranted, let captureSession {
                            CameraPreview(session: captureSession)
                                .ignoresSafeArea()
                        } else {
                            ContentUnavailableView(
                                "Camera Access Required",
                                systemImage: "camera.fill",
                                description: Text("Please allow camera access in Settings.")
                            )
                        }
                    }
                    .onAppear { camera.restart() }
                    .onDisappear { camera.stop() }
                    Button {
                        
                    } label: {
                        Image(systemName: "camera.circle.fill")
                            .font(.system(size: 100))
                    }
                }
                .padding(.vertical)
            }
            Tab("", systemImage: "note", value: 2) {
                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle("Notes / Jobs")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
            }
        }
        .task {
            captureSession = await camera.session
        }
    }
}

//#Preview {
//    ContentView()
//}
