//
//  SettingPage.swift
//  SettingPage
//
//  Created by Abenx on 2021/8/11.
//

import SwiftUI
import ABAlbum

struct SettingPage: View {
    @Environment(\.openURL) var openURL
    @Binding var mediaType: MediaType
    @Binding var colorScheme: UIUserInterfaceStyle
    
    var body: some View {
        List {
            Section(header: Text("Album Setting")) {
                Picker("Media Type", selection: $mediaType) {
                    ForEach(MediaType.allCases, id: \.self) { mode in
                        Text(String(describing: mode).capitalized)
                    }
                }
                .pickerStyle(InlinePickerStyle())
            }
            
            Section(header: Text("Color Scheme")) {
                Picker("Color Scheme", selection: $colorScheme) {
                    Text("System").tag(UIUserInterfaceStyle.unspecified)
                    Text("Light").tag(UIUserInterfaceStyle.light)
                    Text("Dark").tag(UIUserInterfaceStyle.dark)
                }
                .pickerStyle(InlinePickerStyle())
            }
            
#if !os(macOS)
            Section(header: Text("System Setting")) {
                Button("Go to system settings") {
                    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                    openURL(url)
                }
            }
#endif
        }
        .navigationTitle("Settings")
#if !os(macOS)
        .listStyle(.insetGrouped)
#endif
    }
}

struct SettingPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingPage(mediaType: .constant(.both), colorScheme: .constant(.unspecified))
    }
}
