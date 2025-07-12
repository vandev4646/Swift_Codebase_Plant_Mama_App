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
        VStack{
            PlantDetail(plant: $plant, isEditing: isNew ? $isNew : $isEditing, addingReminder:false)
                .toolbar {
                /*
                    ToolbarItem(placement: .cancellationAction) {
                        if isNew {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                    }
  
                    ToolbarItem {
                        Button {
                            if isNew {
                                //plantData.plants.append(plantCopy)
                                dismiss()
                            } else {
                                if isEditing && !isDeleted {
                                    print("Done, saving any changes to \(plant.name).")
                                    withAnimation {
                                        //plant = plantCopy // Put edits (if any) back in the store.
                                    }
                                }
                                isEditing.toggle()
                            }
                        } label: {
                            Text(isNew ? "Add" : (isEditing ? "Done" : "Edit"))
                        }
                    }
   */
                
            }
                
                .onAppear {
                    plantCopy = plant // Grab a copy in case we decide to make edits.
                }
                .disabled(isDeleted)
            
            if isEditing && !isNew {

                Button(role: .destructive, action: {
                    isDeleted = true
                    dismiss()
                    context.delete(plant)
                }, label: {
                    Label("Delete Plant", systemImage: "trash.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                })
                    .padding()
            }
            
        }
        .overlay(alignment: .center) {
            if isDeleted {
                Color(UIColor.systemBackground)
                Text("Event Deleted. Select an Event.")
                    .foregroundStyle(.secondary)
            }
        }
        
    }
    
    
}

#Preview(traits: .plantSampleData) {
    @Previewable @Query(sort: \Plant.name) var plants: [Plant]
    PlantEditor(plant: plants[0])
}

/*
 struct PlantEditor_Previews: PreviewProvider {
 static var previews: some View {
 PlantEditor(plant: .constant(Plant(backingData: <#any BackingData<Plant>#>))).environmentObject(PlantData())
 }
 }
 */
 
