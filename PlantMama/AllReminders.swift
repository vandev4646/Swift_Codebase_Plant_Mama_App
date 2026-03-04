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
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(reminders, id:\.self) { reminder in
                    ZStack{
                        CardBackground()
                        AllRemindersDetails(reminder: reminder)
                    }
                }
            }
        }
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
                    Text("For Plant: " + (reminder.plant?.name ?? " None"))
                    Spacer()
                    Button(action: {
                        cancelNotification(identifer: reminder.id.uuidString)
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
                        .fontWeight(.semibold)
                    Spacer()
                    Text(reminder.date, style: .time)
                        .foregroundColor(.dotBrown)
                        .fontWeight(.semibold)
                }
                
            }.padding()
        }
    }
}
