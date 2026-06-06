//
//  CachedAsyncImage.swift
//  BCA Test Aldino
//
//  Created by Aldino Efendi on 2026/06/06.
//

import SwiftUI
import UIKit

final class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
    private init() {}
}

struct CachedAsyncImage: View {
    let url: URL?
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView()
                    .task {
                        await loadImage()
                    }
            }
        }
    }
}

private extension CachedAsyncImage {
    func loadImage() async {
        guard let url else { return }
        
        if let cachedImage = ImageCache.shared.object(forKey: url as NSURL) {
            image = cachedImage
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let downloadedImage = UIImage(data: data) else { return }
            
            ImageCache.shared.setObject(downloadedImage, forKey: url as NSURL)
            image = downloadedImage
        } catch {
            print(error)
        }
    }
}


