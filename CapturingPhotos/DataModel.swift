//
//  DataModel.swift
//  CapturingPhotos
//
//  Created by Oleksii on 14.02.2025.
//

import AVFoundation
import SwiftUI
import os.log

final class DataModel: ObservableObject {
    let camera = Camera()
    let photoCollection = PhotoCollection(smartAlbum: .smartAlbumUserLibrary)
    
    @Published var viewfinderImage: Image?
    @Published var thumbnailImage: Image?
    
    var isPhotosLoaded = false
    
    init() {
        Task {
            await handleCameraPreviews()
        }
        
        Task {
            await handleCameraPhotos()
        }
    }
}
