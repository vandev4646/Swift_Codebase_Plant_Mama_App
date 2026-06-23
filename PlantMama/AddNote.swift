//
//  AddNote.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 12/26/25.
//

import SwiftUI
import UserNotifications

struct AddNote: View {
    @Binding var plant: Plant
    
    @State var note = Note(title: "", date: Date())
    @State var isAddingPhoto: Bool = false
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: 2)
    // Creates a temporary Binding<Note?> from Binding<Note>
    var optionalNoteBinding: Binding<Note?> {
        Binding<Note?>(
            get: { self.note },
            set: { newValue in
                if let newValue = newValue {
                    self.note = newValue
                }
            }
        )
    }
    let isCreatingNote: Bool
    @State private var title: String
    @State private var date: Date
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var errorWrapper: ErrorWrapper?
    @State private var editingNote: Bool = false
    @State private var deleteNote: Bool = false
    
    init(plant: Binding<Plant>, note: Note?) {
        self._plant = plant
        let noteToEdit: Note
        if let note{
            noteToEdit = note
            isCreatingNote = false
        } else {
            noteToEdit = Note(title: "", date: Date())
            isCreatingNote = true
        }
        
        self.note = noteToEdit
        self.title = noteToEdit.title
        self.date = noteToEdit.date
    }
    

    
    var body: some View {
        NavigationStack{
        if(!editingNote && !isCreatingNote){
            NoteDetails(note: note, columns: gridColumns)
        }
        else {
            List {
                VStack (alignment: .leading) {
                    TextField("Note *", text: $title, axis: .vertical).font(.title2)
                        .lineLimit(1...4)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .labelsHidden()
                        .listRowSeparator(.hidden)
                    
                }.padding()
                HStack{
                    /*
                    Button(action: {
                        isAddingPhoto = true
                    }, label: {Label("Add Photo", systemImage: "photo.badge.plus.fill")})
                    .disabled(title.isEmpty)
                    .buttonStyle(.borderless)
                    .opacity(title.isEmpty ? 0.5: 1.0)
                     */
                    Spacer()
                    Button(action: {
                        do {
                            try saveEdits()
                            dismiss()
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "New Note was not created. Try again later.")
                        }
                        //plant.noteList.append(note)
                        //addingNote.toggle()
                    }, label: {Label("Save!", systemImage: "plus.circle.fill")})
                    .disabled(title.isEmpty)
                    .buttonStyle(.borderless)
                    .opacity(title.isEmpty ? 0.5: 1.0)
                    
                }
                if !isCreatingNote{
                    Button(action: {
                        deleteNote = true
                    }, label: {Label("Delete Note", systemImage: "trash")})
                    .disabled(title.isEmpty)
                    .buttonStyle(.borderless)
                    .opacity(title.isEmpty ? 0.5: 1.0)
                }
                
                ScrollView{
                    NotePhotoGridView(
                        note: $note,
                        photos: $plant.photos,
                        columns: gridColumns
                    )
                }
            }
        }
            
        }.toolbar{
            if !isCreatingNote {
                ToolbarItem(placement: .confirmationAction){
                    Button(editingNote ? "Done" : "Edit"){
                        editingNote.toggle()
                    }.tint(Color(.dotBrown))
                }
            }
            
        }
        .fullScreenCover(isPresented: $isAddingPhoto){
            CameraView(plant: $plant, profilePic: $plant.profilePic, updatingProfile: false, addingNote: optionalNoteBinding)
        }
        .confirmationDialog("Are you sure you want to delete this note?", isPresented: $deleteNote, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                plant.noteList.removeAll(where: { $0.id == note.id })
                    context.delete(note)
                dismiss()
                                
            }
            Button("Cancel", role: .cancel) { }
        } message: {
                Text("This action is permanent.")
            
        }
        
        
    }
    
    private func saveEdits() throws {
        note.title = title
        note.date = date
        
        if isCreatingNote {
            context.insert(note)
            plant.noteList.append(note)
        }
        
        try context.save()
        plant.noteList.append(note)
    }
    
    func formattedDate(date: Date) -> String
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM y"
            return formatter.string(from: date)
        }
    
    
    
    
}
