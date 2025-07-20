//
//  Sidebar.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/16/25.
//

import SwiftUI

struct Sidebar: View {
    let size: Double
    @Binding var addingReminder: Bool
    @Binding var isEditing: Bool
    var body: some View {
        ZStack{
            PinkCardBackground()
            VStack{
                NavigationLink{
                    CameraView()
                } label: {
                    Image(systemName: "camera").foregroundColor(.black)
                }
                Spacer()
                Button(action: {
                    addingReminder.toggle()
                }, label: {
                    Image(systemName: "timer")
                }).foregroundColor(.black)
                Spacer()
                Button(action: {
                    isEditing.toggle()
                }, label: {
                    Image(systemName: "pencil")
                }).foregroundColor(.black)
            }.padding(.top)
                .padding(.bottom)
        }.frame(height: size)
        }
}


