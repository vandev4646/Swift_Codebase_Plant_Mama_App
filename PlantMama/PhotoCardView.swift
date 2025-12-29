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
            AsyncImage(url: photo.url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ZStack{
                    let url = Bundle.main.url(forResource: "Default", withExtension: "png")
                    AsyncImage(url: url){
                        image in image
                            .image?.resizable()
                            .scaledToFill()
                    }
                    ProgressView()
                }
                
            }
            .frame(width: size, height: size)
            //Text(photo.url.absoluteString)
      //  }
    }
}

struct PhotoCardView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "Default", withExtension: "png") {
            PhotoCardView (size: 50, photo: Photo( fileName:"Bundle://Default"))
        }
    }
}
