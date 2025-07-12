//
//  NewPlantSheet.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/25/25.
//

import SwiftUI

struct NewPlantSheet: View {

    var body: some View {
        GeometryReader{
            geometry in
            
            NavigationStack {
                DetailEditView(plant: nil, size: ((geometry.size.height)*(2/5)))
            }
            
        }
    }
}

#Preview {
    NewPlantSheet()
}
