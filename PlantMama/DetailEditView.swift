//
//  DetailEditView.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/25/25.
//

import SwiftUI
import _SwiftData_SwiftUI

struct DetailEditView: View {
    let plant: Plant
    
    @State private var name: String
    @State private var datePurchased: Date
    @State private var type: String
    @State private var details: String
    @State private var profilePic: Photo
    @State private var errorWrapper: ErrorWrapper?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    let isCreatingPlant: Bool
    let size: Double
    
    init(plant: Plant?, size: Double) {
        let plantToEdit: Plant
        if let plant {
            plantToEdit = plant
            isCreatingPlant = false
        } else {
            plantToEdit = Plant(name: "", profilePic: Photo(url: Bundle.main.url(forResource: "Default", withExtension: "png")!), type: "", details: "", reminders: [], photos: [],
                noteList: [])
            isCreatingPlant = true
        }
        
        self.plant = plantToEdit
        self.name = plantToEdit.name
        self.datePurchased = plantToEdit.datePurChased
        self.type = plantToEdit.type
        self.details = plantToEdit.details
        self.size = size
        self.profilePic = plantToEdit.profilePic
        
    }
    
    var body: some View {
        ZStack
        {
            CardBackground()
            
                VStack{
                    
                    SetProfilePic(plant: plant, profilePic: $profilePic, size: 120.0).padding()
                    
                    DetailsEditsRow(label: "Name", value: $name).padding(10)
                    
                    
                    HStack{
                        Text("Date Purchased").padding(.leading, 10)
                                Spacer()
                                DatePicker("Date Purchased", selection: $datePurchased, displayedComponents: [.date])
                                    .labelsHidden()
                                    .listRowSeparator(.hidden)
                                
                        }
                    DetailsEditsRow(label: "Type", value: $type).padding(10)
                       
                    DetailsEditsRow(label: "Details", value: $details).padding(10)
                            
                }
                .padding()
                //.frame(maxWidth: .infinity)
            
        }.frame( height: size)
            .toolbar {
                if isCreatingPlant{
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        do {
                            try saveEdits()
                            dismiss()
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "New Plant was not created. Try again later.")
                        }
                    }.disabled(name.isEmpty)
                }
            }
            .sheet(item: $errorWrapper) {
                dismiss()
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
    }
    
    private func saveEdits() throws {
        plant.name = name
        plant.details = details
        plant.type = type
        plant.datePurChased = datePurchased
        plant.profilePic = profilePic

        if isCreatingPlant {
            plant.photos.append(profilePic)
            context.insert(plant)
        }

        try context.save()
    }
    
}


struct DetailsEditsRow: View {
    var label: String
    @Binding var value: String
    
    var body: some View {
        HStack {
            Text(label).frame(width: .infinity).padding(.trailing)
            Spacer()
            TextField(label, text: $value)
                .bold().frame( alignment: .trailing)
        }
    }
}




#Preview(traits: .plantSampleData) {
    @Previewable @Query(sort: \Plant.name) var plants: [Plant]
    DetailEditView(plant: plants[0], size: 700)
}
