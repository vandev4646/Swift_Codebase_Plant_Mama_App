//
//  NoteRow.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 12/26/25.
//

import SwiftUI

struct NoteRow: View {
    
    @Binding var plant: Plant
    
    var body: some View {
        ScrollView{
            ForEach($plant.noteList, id: \.self){ $note in
                ZStack{
                    CardBackground()
                    VStack(alignment: .leading){
                        HStack {
                            Text(note.title)
                                .foregroundColor(.dotBrown)
                                .fontWeight(.semibold)
                            Spacer()
                            Button(action: {
                                
                            }, label: {Label("", systemImage: "chevron.right.circle").foregroundColor(.dotBrown)
                                .fontWeight(.semibold)})
                        }.padding()
                        
                        HStack {
                            Text(note.date, style: .date)
                                .foregroundColor(.dotBrown)
                                .fontWeight(.semibold)
                        }
                        
                    }.padding()
                }
                
            }
            
        }
    }
        
}
