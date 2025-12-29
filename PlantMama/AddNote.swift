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
    @Binding var addingNote: Bool
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
    
    

    
    var body: some View {
        NavigationStack{
            
            List {
                VStack (alignment: .leading) {
                    TextField("Note", text: $note.title).font(.title2)
                    DatePicker("Date", selection: $note.date, displayedComponents: .date)
                        .labelsHidden()
                        .listRowSeparator(.hidden)
                    
                }.padding()
                HStack{
                    Button(action: {
                        isAddingPhoto = true
                    }, label: {Label("Add Photo", systemImage: "photo.badge.plus.fill")})
                    .disabled(note.title.isEmpty)
                    .buttonStyle(.borderless)
                    Spacer()
                    Button(action: {
                        plant.noteList.append(note)
                        addingNote.toggle()
                    }, label: {Label("Done!", systemImage: "plus.circle.fill")})
                    .disabled(note.title.isEmpty)
                    .buttonStyle(.borderless)
                    
                }
                ScrollView{
                    LazyVGrid(columns: gridColumns) {
                        if let photos = note.photos{
                            ForEach (photos){
                                photo in GeometryReader{
                                    geo in
                                        PhotoCardView(size: geo.size.width, photo: photo)
                                }
                                .cornerRadius(8.0)
                                .aspectRatio(1, contentMode: .fit)
                            }
                        }
                        
                    }.padding()
                }
            }
            .navigationDestination(isPresented: $isAddingPhoto){
                CameraView(plant: $plant, profilePic: $plant.profilePic, updatingProfile: false, addingNote: optionalNoteBinding)
            }
        }
    }
    
    
    
    func formattedDate(date: Date) -> String
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM y"
            return formatter.string(from: date)
        }
}
