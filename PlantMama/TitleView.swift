//
//  TitleView.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/3/25.
//

import SwiftUI

struct TitleView: View {
    var plant: Plant
    var isEditing: Bool = false
    let size: Double
    var body: some View {
            
            
            
                HStack {
                    Spacer()
                    Text(plant.name+"'s Profile")
                        .modifier(FontStyle(size: 30))
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)

                    
                    AsyncImage(url: plant.profilePic.url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 60, maxWidth: 60 , minHeight: 60, maxHeight: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                    } placeholder: {
                        ZStack {
                             let url = Bundle.main.url(forResource: "Default", withExtension: "png")
                             AsyncImage(url: url){
                                 image in image
                                     .image?.resizable()
                                     .scaledToFill()
                                     .clipShape(RoundedRectangle(cornerRadius: 10))
                             }
                            ProgressView()
                        }
                    }.frame(minWidth: 60, maxWidth: 60 , minHeight: 60, maxHeight: 60)
                    Spacer()
                }.modifier(EntryBannerStyle())
            
                
                
            
    
        /*
        ZStack {
            
            
            if isEditing {
                //enter how it should look for edit
            } else {
                HStack {
                    Spacer()
                    //Image(systemName: "leaf.circle.fill")
                     //   .foregroundColor(.dotGreen)
                    AsyncImage(url: plant.profilePic.url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ProgressView()
                    }
                }.modifier(EntryBannerStyle())
                
                Text(plant.name+"'s Profile")
                    .modifier(FontStyle(size: 30))
                    .multilineTextAlignment(.center)
            }
        }*/
    }
}



/*
 struct TitleView_Previews: PreviewProvider {
 static var previews: some View {
 TitleView(plant: .constant(Plant()), isEditing: false)
 }
 }
 */
