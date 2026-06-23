//
//  NotePhotoGridView.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 12/30/25.
//
import SwiftUI

struct NotePhotoGridView: View {
    @Binding var note: Note
    @Binding var photos: [Photo]
    let columns: [GridItem]
    
    var body: some View {
        LazyVGrid(columns: columns) {
                ForEach (photos){ photo in
                    
                    let isSelected = note.photos?.contains(where: { $0.id == photo.id }) ?? false
                    
                    GeometryReader{
                        geo in
                            PhotoCardView(size: geo.size.width, photo: photo)
                            .overlay(alignment: .topTrailing){
                                    Button(action:{
                                        togglePhotoSelection(photo, isSelected: isSelected)
                                    },  label: {
                                        Image(systemName: isSelected ? "xmark.circle.fill": "checkmark.circle")
                                            .foregroundStyle(.white, .gray)
                                            .font(.title3)
                                            .padding(4)
                                    })
                            }
                    }
                    .cornerRadius(8.0)
                    .aspectRatio(1, contentMode: .fit)
                }
            
        }.padding()
    }
    
    private func togglePhotoSelection(_ photo: Photo, isSelected: Bool){
        if isSelected{
            note.photos?.removeAll(where: { $0.id == photo.id})
        } else {
            if note.photos == nil {
                note.photos = [photo]
            }
            note.photos?.append(photo)
        }
    }
    
}
