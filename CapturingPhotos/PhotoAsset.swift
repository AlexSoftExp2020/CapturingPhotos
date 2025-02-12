//
//  PhotoAsset.swift
//  CapturingPhotos
//
//  Created by Oleksii on 12.02.2025.
//

import Photos
import os.log

struct PhotoAsset: Identifiable {
    var id: String { identifier }
    var identifier: String = UUID().uuidString
    var index: Int?
    var phAsset: PHAsset?
    
    typealias MediaType = PHAssetMediaType
    
    var isFavorite: Bool {
        phAsset?.isFavorite ?? false
    }
    
    var mediaType: MediaType {
        phAsset?.mediaType ?? .unknown
    }
    
    var accessibilityLabel: String {
        "Photo\(isFavorite ? ", Favorite" : "")"
    }
    
    
}
