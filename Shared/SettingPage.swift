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
    @AppStorage("mediaType") var mediaType: MediaType = .both
    @AppStorage("colorScheme") var colorScheme: UIUserInterfaceStyle = .unspecified

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
            
            Section(header: Text("System Setting")) {
                Button("Go to system settings") {
                    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                    openURL(url)
                }
            }
        }
        .navigationTitle("Settings")
        .listStyle(.insetGrouped)
    }
}

struct SettingPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingPage()
    }
}
