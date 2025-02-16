//
//  ThumbnailView.swift
//  CapturingPhotos
//
//  Created by Oleksii on 16.02.2025.
//

import SwiftUI

struct ThumbnailView: View {
    var image: Image?
    
    var body: some View {
        ZStack {
            Color.white
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(width: 41, height: 41)
        .cornerRadius(11)
    }
}

#Preview {
    ThumbnailView(image: Image(systemName: "photo.fill"))
}
