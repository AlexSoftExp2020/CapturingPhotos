//
//  ViewfinderView.swift
//  CapturingPhotos
//
//  Created by Oleksii on 16.02.2025.
//

import SwiftUI

struct ViewfinderView: View {
    @Binding var image: Image?
    
    var body: some View {
        GeometryReader { geometry in
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

#Preview {
    ViewfinderView()
}
