//
//  ContentView.swift
//  Shared
//
//  Created by Abenx on 2021/7/27.
//

import SwiftUI
import ABAlbum
import Photos
import Combine

struct ContentView: View {
    
    @AppStorage("colorScheme") var colorScheme: UIUserInterfaceStyle?
    @AppStorage("mediaType") var mediaType: MediaType?
    
    @State private var cancellable: Cancellable?
    
    @State private var selectedAssetLocalIdentifier: String?
    @State private var showsEditorPage: Bool = false
    
    /// 是否显示权限提示页. 默认: 不显示.
    @State private var showsAlbumNoPermissionView: Bool = AlbumAuthorizationStatus.isNotDetermined
    
    var albumPage: some View {
        AlbumPage(showsAlbumNoPermissionView: $showsAlbumNoPermissionView)
            .albumFetchOptions(.fetchOptions(with: mediaType))
            .task {
                showsAlbumNoPermissionView = await !AlbumAuthorizationStatus.hasAlbumPermission
                
                cancellable = NotificationCenter.default
                    .publisher(for: ABAlbum.actionButtonDidClickedNotification)
                    .sink(receiveValue: { notification in
                        print("Action Button Did Clicked", notification)
                        selectedAssetLocalIdentifier = notification.object as? String
                        withAnimation {
                            showsEditorPage = true
                        }
                    })
            }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                List {
                    Section {
                        NavigationLink("Album", destination: albumPage)
                        NavigationLink("Camera", destination:  CameraPage())
                    }
                    Section {
                        NavigationLink("Settings", destination: SettingPage())
                    }
                }
                .listStyle(.insetGrouped)
                
                NavigationLink("", isActive: $showsEditorPage) {
                    EditorPage(selectedAssetLocalIdentifier: $selectedAssetLocalIdentifier)
                }
            }
            Text("Welcome")
        }
        .preferredColorScheme(ColorScheme(colorScheme ?? .unspecified))
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
