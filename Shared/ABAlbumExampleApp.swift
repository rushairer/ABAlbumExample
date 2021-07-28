//
//  ABAlbumExampleApp.swift
//  Shared
//
//  Created by Abenx on 2021/7/27.
//

import SwiftUI

@main
struct ABAlbumExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            #if os(macOS)
                .frame(minWidth: 800, minHeight: 600)
            #endif
        }
    }
}
