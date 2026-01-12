//
//  NotePhotoGridView.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 12/30/25.
//
import SwiftUI

struct NotePhotoGridView: View {
    @Binding var note: Note
    let columns: [GridItem]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            if let photos = note.photos{
                ForEach (photos){
                    photo in GeometryReader{
                        geo in
                            PhotoCardView(size: geo.size.width, photo: photo)
                            .overlay(alignment: .topTrailing){
                                Button(action:{
                                    note.photos?.removeAll(where: { $0.id == photo.id })
                                }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                                            .foregroundStyle(.white, .gray)
                                                            .font(.title3)
                                                            .padding(4)
                                })
                            }
                    }
                    .cornerRadius(8.0)
                    .aspectRatio(1, contentMode: .fit)
                }
            }
            
        }.padding()
    }
}
