//
//  NoteDetails.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 12/30/25.
//
import SwiftUI

struct NoteDetails: View {
    
    let note: Note
    let columns: [GridItem]
    
    var body: some View {
        
        List {
            VStack (alignment: .leading) {
                DetailsRow(label: "Note", value: note.title)
                Spacer()
                DetailsRow(label: "Date", value: note.date.formatted(date: .long, time: .omitted))
                
            }.padding()

            if note.photos.isEmpty{
                ContentUnavailableView("No photos", systemImage: "camera", description: Text("Click edit to add photos to this note."))
            }
            else{
                ScrollView{
                    LazyVGrid(columns: columns) {
                        
                            ForEach (note.photos){
                                photo in GeometryReader{
                                    geo in
                                    PhotoCardView(size: geo.size.width, photo: photo)
                                }
                                .cornerRadius(8.0)
                                .aspectRatio(1, contentMode: .fit)
                            }
                        
                    }.padding()
                }
            }
        }
    }
}
