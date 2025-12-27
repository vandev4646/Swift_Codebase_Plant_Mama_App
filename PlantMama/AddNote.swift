//
//  AddNote.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 12/26/25.
//

import SwiftUI
import UserNotifications

struct AddNote: View {
    let plant: Plant
    @State private var note = Note(title: "", date: Date())
    @Binding var addingNote: Bool
    
    
    var body: some View {
        List {
            VStack (alignment: .center) {
                TextField("Note", text: $note.title).font(.title2)
                DatePicker("Date", selection: $note.date)
                    .labelsHidden()
                    .listRowSeparator(.hidden)
                
            }.padding()
            
            Button(action: {
                plant.noteList.append(note)
                addingNote.toggle()
            }, label: {Label("Add Note", systemImage: "plus")}).disabled(note.title.isEmpty)
        }
    }
    
    
    
    func formattedDate(date: Date) -> String
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM y"
            return formatter.string(from: date)
        }
}
