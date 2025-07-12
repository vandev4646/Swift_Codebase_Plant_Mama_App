//
//  DetailsView.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/7/25.
//

import SwiftUI
import _SwiftData_SwiftUI

struct DetailsView: View {
    let plant: Plant
    let size: Double
    
    var body: some View {
        ZStack
        {
            CardBackground()
            
                VStack{
                        DetailsRow(label: "Name", value: plant.name)
                            .padding()
                        DetailsRow(label: "Age", value: plant.name)
                            .padding()
                        DetailsRow(label: "Type", value: plant.type)
                            .padding()
                        DetailsRow(label: "Notes", value: plant.notes)
                            .padding()
                    
                }
                .padding()
            
        }.frame( height: size)
    }
}

struct DetailsRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            ScrollView{
                Text(value)
            }
        }
    }
}



#Preview(traits: .plantSampleData) {
    @Previewable @Query(sort: \Plant.name) var plants: [Plant]
    DetailsView(plant: plants[0], size: 200)
}
/*
 struct DetailsView_Previews: PreviewProvider {
 static var previews: some View {
 DetailsView( plant: .constant(Plant()), isEditing: false, size: 200)
 }
 }
 */
