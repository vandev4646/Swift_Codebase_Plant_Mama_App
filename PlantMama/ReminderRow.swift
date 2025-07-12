//
//  ReminderRow.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/16/25.
//
import SwiftUI

struct ReminderRow: View {
    
    @Binding var plant: Plant
    
    var body: some View {
        ScrollView{
            ForEach($plant.reminders, id: \.self){ $reminder in
                ZStack{
                    CardBackground()
                    VStack{
                        HStack {
                            Text(reminder.title)
                            Spacer()
                            Button(action: {
                                //context.delete(reminder)
                                plant.reminders.removeAll(where: { $0.id == reminder.id })
                            }, label: {Label("", systemImage: "trash")})
                        }.padding()
                        
                        HStack {
                            Text(reminder.date, style: .date)
                            Spacer()
                            Text(reminder.date, style: .time)
                        }
                        
                    }.padding()
                }
                
                
               // ReminderRowDetails(reminder: $reminder)
               //     .padding()
                
            }
            
        }
    }
        
}




struct ReminderRowDetails: View {
    @Environment(\.modelContext) private var context
    @Binding var reminder: Reminder
    var body: some View {
        ZStack{
            CardBackground()
            VStack{
                HStack {
                    Text(reminder.title)
                    Spacer()
                    Button(action: {
                        context.delete(reminder)
                    }, label: {Label("", systemImage: "trash")})
                }.padding()
                
                HStack {
                    Text(reminder.date, style: .date)
                    Spacer()
                    Text(reminder.date, style: .time)
                }
                
            }.padding()
        }
    }
}
