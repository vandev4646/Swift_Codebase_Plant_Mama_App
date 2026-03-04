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
                            .padding(5)
                        DetailsRow(label: "Age", value: ageFormatted(datePurchased: plant.datePurChased))
                            .padding(5)
                        DetailsRow(label: "Type", value: plant.type)
                            .padding(5)
                        DetailsRowScroll(label: "Details", value: plant.details)
                            .padding(5)
                    
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
                .foregroundColor(.dotBrown)
                .fontWeight(.semibold)
                .modifier(FontStyle(size: 20))
            Spacer()
                Text(value)
                    .foregroundColor(.dotBrown)
                    .modifier(FontStyle(size: 20))
          
        }
    }
}

struct DetailsRowScroll: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .foregroundColor(.dotBrown)
                .fontWeight(.semibold)
                .modifier(FontStyle(size: 20))
                .lineLimit(1...4)
            Spacer()
            ScrollView{
                Text(value)
                    .foregroundColor(.dotBrown)
                    .modifier(FontStyle(size: 20))
                    .lineLimit(1...4)
            }
        }
    }
}

func ageFormatted(datePurchased: Date) -> String {
    let ageFormatter = DateComponentsFormatter()
    // Set the units we want to potentially display
    ageFormatter.allowedUnits = [.year, .month, .day]
    // Specify that we want the units to be provided in a full style (e.g., "1 year, 9 months")
    ageFormatter.unitsStyle = .full
    // Only show at most two of the units (e.g. "1 year, 9 months", "1 month, 1 day", etc.)
    ageFormatter.maximumUnitCount = 2
    return ageFormatter.string(from: datePurchased, to: Date()) ?? "Unknown"
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
