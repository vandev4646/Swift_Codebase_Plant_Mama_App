//
//  AllPhotos.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/10/26.
//

import SwiftUI
import SwiftData

struct AllPhotos: View {
    @Query private var photos: [Photo]
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        ZStack{
            if !photos.isEmpty {
                    ScrollView{
                        LazyVGrid(columns: gridColumns) {
                            ForEach (photos){
                                photo in GeometryReader{
                                    geo in
                                    NavigationLink(destination: PhotoDetail(plant: photo.plant, photo: photo, type: .all)){
                                            PhotoCardView(size: geo.size.width, photo: photo)
                                        }
                                    
                                }
                                .cornerRadius(8.0)
                                .aspectRatio(1, contentMode: .fit)
                            }
                        }.padding()
                    }
                    
                
                
            } else{
                ContentUnavailableView("No Photos", systemImage: "camera", description: Text("To add a new photo, navigate to a plant profile. Then click on the camera icon on the right sidebar to add photos for this plant."))
            }
            
        }.background(
            Image("MenuBackground")
                .resizable()
                .modifier(BackgroundStyle()))
        
    }
    
}
