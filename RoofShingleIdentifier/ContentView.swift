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
                Text("camera")
            }
            Tab("", systemImage: "note", value: 2) {
                Text("notes")
            }
            Tab("", systemImage: "doc", value: 3) {
                Text("idk what this tab will be")
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
