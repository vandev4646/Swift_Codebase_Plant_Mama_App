//
//  PlantDetail.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/16/25.
//

import SwiftUI

struct PlantDetail: View {
    @Binding var plant: Plant
    @Binding var isEditing: Bool
    @State var addingReminder: Bool
    
    var body: some View {
        if !isEditing{
            GeometryReader{
                geometry in
                
                VStack{
                    TitleView(plant: plant)
                    HStack{
                        DetailsView(plant: plant, size: ((geometry.size.height)*(2/5)))
                        Sidebar(size:((geometry.size.height)*(1/3)), addingReminder: $addingReminder, isEditing: $isEditing)
                    }
                    SegmentView(plant: $plant)
                }
                .sheet(isPresented: $addingReminder) {
                    NavigationView {
                        AddReminder(plant: plant, addingReminder: $addingReminder)
                    }
                }
                .background(
                    Image("MenuBackground")
                        .resizable()
                        .modifier(BackgroundStyle())
                )
            }
            
        }
        else{
            DetailEditView(plant: plant, size: 300)
        }
    }
}

/*
struct PlantDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlantDetail(plant: .constant(Plant()), isEditing: true)
    }
}
*/
