//
//  PhotoLibraryHelpers.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/9/26.
//

import SwiftUI
import Photos

struct LibraryImage: View {
    let identifier: String
    var size: CGSize? = nil
    @State private var loadedImage: UIImage? = nil

    var body: some View {
        ZStack {
            if let image = loadedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                // Placeholder while loading or if it's the "Default"
                Image("Default")
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(width: size?.width, height: size?.height)
        .task(id: identifier) {
            // Guard against default and only load if missing
            guard identifier != "Default", !identifier.isEmpty else { return }
            await loadImage()
        }
    }

    private func loadImage() async {
        let fetchOptions = PHFetchOptions()
        let results = PHAsset.fetchAssets(
            withLocalIdentifiers: [identifier],
            options: fetchOptions
        )
        guard let asset = results.firstObject else { return }
        let targetSize = size ?? CGSize(width: 1000, height: 1000)
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .opportunistic
        options.isSynchronous = false

        // Request image asynchronously
        let fetchedImage: UIImage? = await withCheckedContinuation { continuation in
            PHImageManager.default().requestImage(
                for: asset,
                targetSize: targetSize,
                contentMode: .aspectFill,
                options: options
            ) { result, info in
                let isDegraded = info?[PHImageResultIsDegradedKey] as? Bool ?? false
                if !isDegraded { continuation.resume(returning: result) }
            }
        }

        if let fetchedImage {
            await MainActor.run {
                self.loadedImage = fetchedImage
            }
        }
    }
}

