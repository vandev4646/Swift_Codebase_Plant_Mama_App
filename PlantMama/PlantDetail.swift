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
    @State var addingNote: Bool
    
    var body: some View {
        if !isEditing{
            GeometryReader{
                geometry in
                
                VStack{
                    TitleView(plant: plant, size: geometry.size.width)
                    HStack{
                        DetailsView(plant: plant, size: ((geometry.size.height)*(2/5)))
                        Sidebar(size:((geometry.size.height)*(1/3)), plant: $plant, addingReminder: $addingReminder, isEditing: $isEditing, addingNote: $addingNote)
                    }
                    SegmentView(plant: $plant)
                }
                .sheet(isPresented: $addingReminder) {
                    NavigationView {
                        AddReminder(plant: plant, addingReminder: $addingReminder)
                    }
                }
                .sheet(isPresented: $addingNote) {
                    NavigationView {
                        AddNote(plant: plant, addingNote: $addingNote)
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
            GeometryReader{
                geometry in
                DetailEditView(plant: plant, size: geometry.size.height*(0.7))
            }
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
