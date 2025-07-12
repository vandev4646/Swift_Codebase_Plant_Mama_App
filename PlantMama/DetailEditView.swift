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
    @State private var notes: String
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
            plantToEdit = Plant(name: "", profilePic: "Default", type: "", notes: "", reminders: [], photos: [])
            isCreatingPlant = true
        }
        
        self.plant = plantToEdit
        self.name = plantToEdit.name
        self.datePurchased = plantToEdit.datePurChased
        self.type = plantToEdit.type
        self.notes = plantToEdit.notes
        self.size = size
        
    }
    
    var body: some View {
        ZStack
        {
            CardBackground()
            
                VStack{
                   
                    
                        DetailsEditsRow(label: "Name", value: $name).padding()
                        HStack{
                            Text("Date Purchased")
                            DatePicker("Date Purchased", selection: $datePurchased)
                                .labelsHidden()
                                .listRowSeparator(.hidden)
                            
                        }
                        DetailsEditsRow(label: "Type", value: $type).padding()
                        DetailsEditsRow(label: "Notes", value: $notes).padding()
                            
                    
                    
                }
                .padding()
            
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
                    }
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
        plant.notes = notes
        plant.type = type
        plant.datePurChased = datePurchased

        if isCreatingPlant {
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
            Text(label)
            Spacer()
            TextField(label, text: $value)
        }
    }
}


#Preview(traits: .plantSampleData) {
    @Previewable @Query(sort: \Plant.name) var plants: [Plant]
    DetailEditView(plant: plants[0], size: 200)
}
