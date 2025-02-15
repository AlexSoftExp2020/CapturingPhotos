//
//  PhotoCollection.swift
//  CapturingPhotos
//
//  Created by Oleksii on 15.02.2025.
//

import Photos
import os.log

class PhotoCollection: NSObject, ObservableObject {
    @Published var photoAssets: PhotoAssetCollection = PhotoAssetCollection(PHFetchResult<PHAsset>())
    
    var identifier: String? {
        assetCollection?.localIdentifier
    }
    
    var albumName: String?
    
    var smartAlbumType: PHAssetCollectionSubtype?
    
    let cache = CachedImageManager()
    
    private var assetCollection: PHAssetCollection?
    
    private var createAlbumIfNotFound = false
}
