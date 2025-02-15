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
    
    enum  PhotoCollectionError: LocalizedError {
        case missingAssetCollection
        case missingAlbumName
        case missingLocalIdentifier
        case unableToFindAlbum(String)
        case unableToLoadSmartAlbum(PHAssetCollectionSubtype)
        case addImageError(Error)
        case createAlbumError(Error)
        case removeAllError(Error)
    }
    
    init(albumNamed albumName: String, createIfNotFound: Bool = false) {
        self.albumName = albumName
        self.createAlbumIfNotFound = createIfNotFound
        super.init()
    }
    
    init?(albumWithIdentifier identifier: String) {
        guard let assetCollection = PhotoCollection.getAlbum(identifier: identifier) else {
            logger.error("Photo album not found for identifier: \(identifier)")
            return nil
        }
        logger.log("Loaded photo album with identifier: \(identifier)")
        self.assetCollection = assetCollection
        super.init()
        Task {
            await refreshPhotoAssets()
        }
    }
    
    init(smartAlbum smartAlbumType: PHAssetCollectionSubtype) {
        self.smartAlbumType = smartAlbumType
        super.init()
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    func load() async throws {
        
        PHPhotoLibrary.shared().register(self)
        
        if let smartAlbumType = smartAlbumType {
            if let assetCollection = PhotoCollection.getSmartAlbum(subtype: smartAlbumType) {
                logger.log("Loaded smart album of type: \(smartAlbumType.rawValue)")
                self.assetCollection = assetCollection
                await refreshPhotoAssets()
                return
            } else {
                logger.error("Unable to load smart album of type: : \(smartAlbumType.rawValue)")
                throw PhotoCollectionError.unableToLoadSmartAlbum(smartAlbumType)
            }
        }
        
        guard let name = albumName, !name.isEmpty else {
            logger.error("Unable to load an album without a name.")
            throw PhotoCollectionError.missingAlbumName
        }
        
        if let assetCollection = PhotoCollection.getAlbum(named: name) {
            logger.log("Loaded photo album named: \(name)")
            self.assetCollection = assetCollection
            await refreshPhotoAssets()
            return
        }
        
        guard createAlbumIfNotFound else {
            logger.error("Unable to find photo album named: \(name)")
            throw PhotoCollectionError.unableToFindAlbum(name)
        }

        logger.log("Creating photo album named: \(name)")
        
        if let assetCollection = try? await PhotoCollection.createAlbum(named: name) {
            self.assetCollection = assetCollection
            await refreshPhotoAssets()
        }
    }
}
