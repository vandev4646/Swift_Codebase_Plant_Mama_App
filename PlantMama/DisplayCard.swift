//
//  DisplayCard.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/12/25.
//

import SwiftUI

struct DisplayCard: View {
    let plant: Plant
    let size: Double
    var isEditing: Bool = false
    
  
    
    var body: some View {
        //let imageName = ImageModel(fileName: plant.profilePic,location: .resources)
        
        ZStack(alignment: .bottom) {
            if !isEditing {
                
                if let uiImage = plant.profilePic.image{
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } else {
                    Image("Default")
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .background(Color(.systemGray6))
                }
            }
            
            ZStack(alignment: .center){
                
                RoundedRectangle(cornerRadius: 20.0)
                    .aspectRatio(5, contentMode: ContentMode.fit)
                    .foregroundColor(.white)
                    .opacity(0.9)
                    .frame(maxWidth: size * 7/8)
                
                Text(plant.name)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.dotBrown)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                
            }.padding()
        }.frame(minWidth: size, maxWidth: size , minHeight: size, maxHeight: size)
    }
}


/*
 #Preview {
 let plant = Plant.sampleData[0]
 DisplayCard(plant: plant, size: 200)
 }
 */
