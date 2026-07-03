//
//  PhotoRow.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/8/25.
//

import SwiftUI

struct PhotoCardView: View {
    let size: Double
    let photo: Photo
    
    var body: some View {
       // ZStack(alignment: .topTrailing) {
        if let uiImage = photo.image {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipped()
        } else {
            ContentUnavailableView("No Image", systemImage: "photo.badge.plus"
                                   , description: Text("Image not found. Remove this placeholder and add a new image."))
                .frame(width: size, height: size)
                .background(Color(.systemGray6))
        }
    }
}

struct PhotoCardView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCardView(size: 100, photo: Photo(identifier: "Default"))
                   .previewLayout(.sizeThatFits)
    }
}
