//
//  CapturingPhotosApp.swift
//  CapturingPhotos
//
//  Created by Oleksii on 12.02.2025.
//

import SwiftUI

@main
struct CapturingPhotosApp: App {
    
    init() {
        UINavigationBar.applyCustomAppearance()
    }
    var body: some Scene {
        WindowGroup {
        //MARK: TODO CameraView()
        }
    }
}

fileprivate extension UINavigationBar {
    
    static func applyCustomAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
}
