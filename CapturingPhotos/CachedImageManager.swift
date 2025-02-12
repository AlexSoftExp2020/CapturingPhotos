//
//  CachedImageManager.swift
//  CapturingPhotos
//
//  Created by Oleksii on 12.02.2025.
//

import UIKit
import Photos
import SwiftUI
import os.log

actor CachedImageManager {
    
    private let imageManager = PHCachingImageManager()
    
    private var imageContentMode = PHImageContentMode.aspectFit
    
    enum CachedImageManagerError: LocalizedError {
        case error(Error)
        case cancelled
        case failed
    }
}
