//
//  Sidebar.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/16/25.
//

import SwiftUI

struct Sidebar: View {
    let size: Double
    @Binding var plant : Plant
    @Binding var addingReminder: Bool
    @Binding var isEditing: Bool
    @Binding var addingNote: Bool
   
    var body: some View {
        ZStack{
            PinkCardBackground()
            VStack{
                NavigationLink{
                    //PhotoPicker(plant:$plant)
                    CameraView(plant: $plant, updatingProfile: false, profilePic: $plant.profilePic)
                        
                } label: {
                    Image(systemName: "camera")
                        .fontWeight(.bold)
                        .foregroundColor(.dotBrown)
                }
                Spacer()
                Button(action: {
                    addingReminder.toggle()
                }, label: {
                    Image(systemName: "timer")
                }).fontWeight(.bold)
                    .foregroundColor(.dotBrown)
                Spacer()
                Button(action: {
                    isEditing.toggle()
                }, label: {
                    Image(systemName: "pencil")
                }).fontWeight(.bold)
                    .foregroundColor(.dotBrown)
                Spacer()
                Button(action: {addingNote.toggle()}, label: {Image(systemName: "note.text.badge.plus")}).fontWeight(.bold).foregroundColor(.dotBrown)
            }.padding(.top)
                .padding(.bottom)
        }.frame(height: size)
        }
}


