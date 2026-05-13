//
//  PhotoLibraryHelpers.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/9/26.
//

import SwiftUI
import Photos

struct PhotoLibraryAssetModifier: ViewModifier {
    let identifier: String
    @State private var loadedImage: UIImage? = nil
    @State private var lastLoadedID: String = "" // Track what we actually loaded

    func body(content: Content) -> some View {
        Group {
            if let image = loadedImage {
                Image(uiImage: image)
                    .resizable()
            } else {
                content
            }
        }
        .task(id: identifier) {
            // ONLY load if the ID has actually changed and we haven't loaded it yet
            if identifier != lastLoadedID {
                await loadImage()
            }
        }
    }

    private func loadImage() async {
        guard identifier != "Default", !identifier.isEmpty else { return }

        let results = PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: nil)
        guard let asset = results.firstObject else { return }

        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .opportunistic // Faster for grids
        options.isSynchronous = false

        let image: UIImage? = await withCheckedContinuation { continuation in
            PHImageManager.default().requestImage(
                for: asset,
                targetSize: CGSize(width: 400, height: 400), // Keep size small for the grid!
                contentMode: .aspectFill,
                options: options
            ) { result, info in
                // Only resume for the final image, not the placeholder
                let isDegraded = info?[PHImageResultIsDegradedKey] as? Bool ?? false
                if !isDegraded {
                    continuation.resume(returning: result)
                }
            }
        }
        
        await MainActor.run {
            self.loadedImage = image
            self.lastLoadedID = identifier // Mark this ID as "done"
        }
    }
}

extension View {
    func loadFromLibrary(id: String, size: CGSize = CGSize(width: 1024, height: 1024)) -> some View {
        self.modifier(PhotoLibraryAssetModifier(identifier: id))
    }
}
