//
//  ContentView.swift
//  Shared
//
//  Created by Abenx on 2021/7/27.
//

import SwiftUI
import ABAlbum
import Photos

struct ContentView: View {
    @State private var mediaType: MediaType = .both
    @State private var colorScheme: UIUserInterfaceStyle = .unspecified
        
    /// 是否显示权限提示页. 默认: 不显示.
    @State private var showsAlbumNoPermissionView: Bool = AlbumAuthorizationStatus.isNotDetermined
    
    var albumPage: some View {
        AlbumPage()
            .showsNoPermissionView($showsAlbumNoPermissionView)
            .albumFetchOptions(AlbumFetchOptions.fetchOptions(with: mediaType))
            .task {
                showsAlbumNoPermissionView = await !AlbumAuthorizationStatus.hasAlbumPermission
            }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink("Album", destination: albumPage)
                    
                    NavigationLink("Camera", destination:  CameraPage())
                }

                Section {
                    NavigationLink("Settings", destination: SettingPage(mediaType: $mediaType, colorScheme: $colorScheme))
                }

            }
            .listStyle(.insetGrouped)
            Text("Welcome")
        }
        .preferredColorScheme(ColorScheme(colorScheme))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .previewInterfaceOrientation(.landscapeRight)
            ContentView()
                .preferredColorScheme(.dark)
                .accentColor(.pink)
            ContentView()
                .previewDevice("iPad mini (5th generation)")
        }
    }
}
