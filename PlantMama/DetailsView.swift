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
                    DetailsRow(label: "Age", value: String(format: "%.f", age(yearPurchased: plant.datePurChased))+" Years" )
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
            //ScrollView{
                Text(value)
                    .foregroundColor(.dotBrown)
                    .modifier(FontStyle(size: 20))
          //  }
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
            Spacer()
            ScrollView{
                Text(value)
                    .foregroundColor(.dotBrown)
                    .modifier(FontStyle(size: 20))
            }
        }
    }
}

func age(yearPurchased: Date) -> Double {
    let components = Calendar.current.dateComponents([.month], from: yearPurchased, to: Date())
    guard let months = components.month else { return 0.0 }
    return Double(months)/12.0
    
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
