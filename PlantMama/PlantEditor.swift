//
//  PlantEditor.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/24/25.
//

import SwiftUI
import _SwiftData_SwiftUI

struct PlantEditor: View {
    @State var plant: Plant
    @State var isNew = false
    
    @State private var isDeleted = false
    //@EnvironmentObject var plantData: PlantData
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var plantCopy: Plant?
    @State private var isEditing = false
    
    
    
   // private var isEventDeleted: Bool {
       // !plantData.exists(plant) && !isNew
 //       isNew
 //   }
    
    
    var body: some View {
        VStack(){
            if isEditing {
                Spacer()
            }
            PlantDetail(plant: $plant, isEditing: isNew ? $isNew : $isEditing, addingReminder:false, addingNote: false)
                
                .onAppear {
                    plantCopy = plant // Grab a copy in case we decide to make edits.
                }
                .disabled(isDeleted)
            
            if isEditing && !isNew {

                Button(role: .destructive, action: {
                    isDeleted = true
                    
                }, label: {
                    Label("Delete Plant", systemImage: "trash.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                })
                    .padding(50)
            }
            
        }
        .confirmationDialog("Are you sure?", isPresented: $isDeleted, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                Task {
                    
                    context.delete(plant)
                    dismiss()
                    
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
                Text("Deleting this plant is permanent and will remove all reminders, notes, and photos associated with it.")
            
        }
        
    }
    
    
}
/*
#Preview(traits: .plantSampleData) {
    @Previewable @Query(sort: \Plant.name) var plants: [Plant]
    PlantEditor(plant: plants[0])
}


 struct PlantEditor_Previews: PreviewProvider {
 static var previews: some View {
 PlantEditor(plant: .constant(Plant(backingData: <#any BackingData<Plant>#>))).environmentObject(PlantData())
 }
 }
 */
 
