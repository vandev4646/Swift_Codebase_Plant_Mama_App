//
//  AllReminders.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 1/28/26.
//

import SwiftUI
import SwiftData

struct AllReminders: View {
    //@State var reminders: [Reminder]
    @Query(sort: \Reminder.date) private var reminders: [Reminder]
    
        private var groupedReminders: [String: [Reminder]] {
            Dictionary(grouping: reminders, by: { $0.plant?.name ?? "Unknown Plant" })
        }

        private var plantNames: [String] {
            groupedReminders.keys.sorted()
        }
    
    var body: some View {
        ZStack{
            
            if !reminders.isEmpty {
                ScrollView{
                    VStack(alignment: .leading, spacing:20){
                        
                        ForEach(plantNames, id: \.self) { name in
                            VStack(alignment: .leading, spacing: 10) {
                                // Section Header
                                Text("\(name)'s: Reminders")
                                    .font(.headline)
                                    .foregroundColor(.dotBrown)
                                    .padding(.horizontal)
                                
                                // The Reminders for this specific plant
                                ForEach(groupedReminders[name] ?? [], id: \.self) { reminder in
                                    ZStack{
                                        CardBackground()
                                        AllRemindersDetails(reminder: reminder)
                                    }
                                }
                            }}}
                    
                }
                
            } else{
                ContentUnavailableView("No Reminders", systemImage: "timer", description: Text("To add a new reminder, navigate to a plant profile. Then click on the timer icon on the right sidebar to add reminders for that plant."))
            }
            
        }.background(
            Image("MenuBackground")
                .resizable()
                .modifier(BackgroundStyle())
    )
        
    }
    
    struct AllRemindersDetails: View {
        @State var reminder: Reminder
        @Environment(\.modelContext) private var context
        var body: some View {
            VStack{
                HStack {
                    Text(reminder.title)
                        .foregroundColor(.dotBrown)
                        .fontWeight(.semibold)
            
                    Spacer()
                    Button(action: {
                        cancelNotification(identifier: reminder.id.uuidString)
                        context.delete(reminder)
                    }, label: {
                        Label("", systemImage: "trash")
                            .foregroundColor(.dotBrown)
                            .fontWeight(.semibold)
                    })
                    .buttonStyle(.borderless)
                }.padding()
                
                HStack {
                    Text(reminder.date, style: .date)
                        .foregroundColor(.dotBrown)
                        .fontWeight(.regular)
                    Text(":")
                        .foregroundColor(.dotBrown)
                        .fontWeight(.regular)
                    //Spacer()
                    Text(reminder.date, style: .time)
                        .foregroundColor(.dotBrown)
                        .fontWeight(.regular)
                    Spacer()
                    Text("Frequency: ")
                        .foregroundColor(.dotBrown)
                        .fontWeight(.regular)
                    Text(reminder.frequency.rawValue)
                        .foregroundColor(.dotBrown)
                        .fontWeight(.regular)
                }
                
            }.padding()
                .onAppear{
                    if let plant = reminder.plant {
                        cleanupExpiredReminders(plant: plant, context: context)
                    }
                }
        }
    }
}
