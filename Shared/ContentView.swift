//
//  ContentView.swift
//  Shared
//
//  Created by Abenx on 2021/7/27.
//

import SwiftUI
import ABAlbum

struct ContentView: View {
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink("Album", destination:  AlbumPage())
                    NavigationLink("Camera", destination:  CameraPage())
                }
                Section {
                    Button("Go to system settings") {
                        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                        openURL(url)
                    }
                }
            }
            .listStyle(.insetGrouped)
            Text("Welcome")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
#if os(iOS)
            ContentView()
                .previewInterfaceOrientation(.landscapeRight)
            ContentView()
                .preferredColorScheme(.dark)
                .accentColor(.pink)
            ContentView()
                .previewDevice("iPad mini (5th generation)")
#endif
        }
    }
}
