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
    var body: some View {
        ZStack {
            
            
            if isEditing {
                //enter how it should look for edit
            } else {
                HStack {
                    Spacer()
                    Image(systemName: "leaf.circle.fill")
                        .foregroundColor(.dotGreen)
                }.modifier(EntryBannerStyle())
                
                Text(plant.name+"'s Profile")
                    .modifier(FontStyle(size: 30))
                    .multilineTextAlignment(.center)
            }
        }
    }
}



/*
 struct TitleView_Previews: PreviewProvider {
 static var previews: some View {
 TitleView(plant: .constant(Plant()), isEditing: false)
 }
 }
 */
