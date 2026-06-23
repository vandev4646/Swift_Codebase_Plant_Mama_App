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
        LibraryImage(identifier: photo.identifier, size: CGSize(width: size, height: size))
                    .frame(width: size, height: size)
                    .clipped() // Ensures image doesn't bleed outside the frame
    }
}

struct PhotoCardView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCardView(size: 100, photo: Photo(identifier: "Default"))
                   .previewLayout(.sizeThatFits)
    }
}
