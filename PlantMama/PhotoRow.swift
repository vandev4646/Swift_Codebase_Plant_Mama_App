//
//  PhotoRow.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/8/25.
//

import SwiftUI

struct PhotoRow: View {
    var plant: Plant
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: gridColumns) {
                ForEach (plant.photos){
                    photo in GeometryReader{
                        geo in PhotoCardView(size: geo.size.width, photo: photo)
                    }
                    .cornerRadius(8.0)
                    .aspectRatio(1, contentMode: .fit)
                }
            }.padding()
        }
        
    }
}
/*
 struct PhotoRow_Previews: PreviewProvider {
 static var previews: some View {
 PhotoRow(plant: .constant(Plant()))
 }
 }
 */
