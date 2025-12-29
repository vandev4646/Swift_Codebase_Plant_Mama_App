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
                                .foregroundColor(.dotBrown)
                                .fontWeight(.semibold)
                            Spacer()
                            Button(action: {
                                //context.delete(reminder)
                                cancelNotification(identifer: reminder.id.uuidString)
                                plant.reminders.removeAll(where: { $0.id == reminder.id })
                            }, label: {Label("", systemImage: "trash").foregroundColor(.dotBrown)
                                .fontWeight(.semibold)})
                        }.padding()
                        
                        HStack {
                            Text(reminder.date, style: .date)
                                .foregroundColor(.dotBrown)
                                .fontWeight(.semibold)
                            Spacer()
                            Text(reminder.date, style: .time)
                                .foregroundColor(.dotBrown)
                                .fontWeight(.semibold)
                        }
                        
                    }.padding()
                }
                
            }
            
        }.onAppear{
            cleanupExpiredReminders(plant: plant)
        }
    }
        
}


