//
//  ContentView.swift
//  RoofShingleIdentifier
//
//  Created by Travis Domenic Ratliff on 4/23/26.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("", systemImage: "camera", value: 1) {
                NavigationStack {
                    VStack {
                        
                        Button {
                            
                        } label: {
                            Circle()
                                .foregroundStyle(.red)
                                .frame(height: 100)
                        }
                    }
                    .padding(.vertical)
                }
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
    }
}

//#Preview {
//    ContentView()
//}
