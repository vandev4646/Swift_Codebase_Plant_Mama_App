//
//  SetProfilePic.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 7/29/25.
//

import SwiftUI

struct SetProfilePic: View {
    @State var plant: Plant
    @Binding var profilePic: Photo
    var isEditing: Bool = false
    let size: Double
  
    
    var body: some View {
        //let imageName = ImageModel(fileName: plant.profilePic,location: .resources)
        
        ZStack(alignment: .bottom) {
            if !isEditing {
                LibraryImage(identifier: profilePic.identifier, size: CGSize(width: size, height: size))
                        //.resizable()
                        .scaledToFill()
                        .frame(minWidth: size, maxWidth: size , minHeight: size, maxHeight: size)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
            }
            
            ZStack(alignment: .center){
                
               // RoundedRectangle(cornerRadius: 20.0)
               //     .aspectRatio(5, contentMode: ContentMode.fit)
               //     .foregroundColor(.white)
               //     .opacity(0.9)
                
                NavigationLink{
                    CameraView(plant: $plant, profilePic: $profilePic, updatingProfile: true)
                } label: {
                    Text("Click to set profile pic")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.dotBrown)
                        .background(RoundedRectangle(cornerRadius: 10.0).foregroundColor(.white).opacity(0.9)).padding()
                }
                
            }
        }.frame(minWidth: size, maxWidth: size , minHeight: size, maxHeight: size)
    }
}


/*
 #Preview {
 let plant = Plant.sampleData[0]
 SetProfilePic(plant: plant)
 }
 */
