//
//  PHImageManager+Concurrency.swift
//  SwiftConcurrencyExtensions
//
//  Created by Abenx on 2021/8/18.
//

import UIKit
import Photos

@available(iOS 15, *)
extension PHImageManager {
    open func requestImage(for asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?) -> AsyncStream<(UIImage?, [AnyHashable : Any]?)> {
        AsyncStream<(UIImage?, [AnyHashable : Any]?)> { [unowned self] continuation in
            self.requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, info in
                continuation.yield((image, info))
                if let _ = info?[PHImageResultIsDegradedKey],
                   !(info![PHImageResultIsDegradedKey] as! Bool) {
                    continuation.finish()
                }
                
                continuation.onTermination = { @Sendable [unowned self] terminal in
                    switch terminal {
                    case .cancelled:
                        if let requestIDKey = info?[PHImageResultIsDegradedKey] as? PHImageRequestID {
                            self.cancelImageRequest(requestIDKey)
                        }
                    default: break
                    }
                }
            }
        }
    }
}
