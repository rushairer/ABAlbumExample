//
//  ContentView.swift
//  Shared
//
//  Created by Abenx on 2021/7/27.
//

import SwiftUI
import ABAlbum

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Album", destination:  AlbumPage())
                NavigationLink("Camera", destination:  CameraPage())
            }
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
