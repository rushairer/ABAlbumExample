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
    @Environment(\.openURL) var openURL
    
    /// 是否显示权限提示页. 默认: 不显示.
    @State private var showsAlbumNoPermissionView: Bool = AlbumService.shared.isNotDetermined
    
    init() {
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "mediaType == %ld", PHAssetMediaType.image.rawValue)
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        AlbumService.shared.collectionFetchOptions = options
    }
    
    var albumPage: some View {
        AlbumPage()
            .showsNoPermissionView($showsAlbumNoPermissionView)
            .task {
                showsAlbumNoPermissionView = await !AlbumService.shared.hasAlbumPermission
            }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink("Album", destination: albumPage)
                    NavigationLink("Camera", destination:  CameraPage())
                }
#if !os(macOS)
                Section {
                    Button("Go to system settings") {
                        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                        openURL(url)
                    }
                }
#endif
            }
#if !os(macOS)
            .listStyle(.insetGrouped)
#endif
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
