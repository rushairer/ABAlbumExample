//
//  EditorPage.swift
//  EditorPage
//
//  Created by Abenx on 2021/8/18.
//

import SwiftUI
import SwiftConcurrencyExtensions
import Photos
import ZoomableImageView

struct EditorPage: View {
    @Binding var selectedAssetLocalIdentifier: String?
    
    @State private var appeared: Double = 0
    
    @State private var rawImage: UIImage = UIImage()
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ZoomableImageView(image: rawImage)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .overlay(
                        ProgressView().opacity(rawImage == UIImage() ? 1 : 0)
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .offset(x: proxy.size.width * (1 - appeared), y: 0)
            .offset(x: proxy.size.width * (1 - appeared), y: 0)
            .animation(.spring(), value: appeared)
            .task {
                guard rawImage == UIImage() else { return }
                guard let selectedAssetLocalIdentifier = selectedAssetLocalIdentifier else { return }
                let asset = PHAsset.fetchAssets(withLocalIdentifiers: [selectedAssetLocalIdentifier], options: nil).firstObject
                guard let asset = asset else { return }
                async let stream = PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 4096, height: 4096), contentMode: .default, options: nil)
                
                do {
                    for try await (image, info) in await stream {
                        guard let image = image else { continue }
                        rawImage = image
                        
                        if ((info?[PHImageErrorKey]) != nil) {
                            throw NSError()
                        }
                    }
                } catch let error {
                    print(error)
                }
            }
            .navigationTitle("Editor")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
            .onAppear {appeared = 1.0}
            .onDisappear {appeared = 0.0}
        }
    }
}

struct EditorPage_Previews: PreviewProvider {
    static var previews: some View {
        EditorPage(selectedAssetLocalIdentifier: .constant(""))
    }
}
