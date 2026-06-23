//
//  ReminderRow.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/16/25.
//
import SwiftUI
import SwiftData

struct ReminderRow: View {
    
    @Binding var plant: Plant
    @State var deleteReminder: Bool = false
    @State private var selectedReminder: Reminder?
    @Environment(\.modelContext) private var context
    
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
                                selectedReminder = reminder
                                deleteReminder = true
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
            cleanupExpiredReminders(plant: plant, context: context)
        }
        .confirmationDialog("Are you sure you want to delete this reminder?", isPresented: $deleteReminder, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                if let reminderToDelete = selectedReminder {
                                    cancelNotification(identifier: reminderToDelete.id.uuidString)
                                    plant.reminders.removeAll(where: { $0.id == reminderToDelete.id })
                                    context.delete(reminderToDelete)
                                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
                Text("This action is permanent.")
            
        }
    }
        
}


