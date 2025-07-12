//
//  AddReminder.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/16/25.
//

import SwiftUI

struct AddReminder: View {
    let plant: Plant
    @State private var reminder = Reminder(title: "", date: Date())
    @Binding var addingReminder: Bool
    var body: some View {
        List {
            VStack (alignment: .center) {
                TextField("Reminder Name", text: $reminder.title).font(.title2)
                DatePicker("Date", selection: $reminder.date)
                    .labelsHidden()
                    .listRowSeparator(.hidden)
                
            }.padding()
            
            Button(action: {
                plant.reminders.append(reminder)
                addingReminder.toggle()
            }, label: {Label("Add Reminder", systemImage: "plus")})
        }
        
    }
}

/*
 struct AddReminder_Previews: PreviewProvider {
 static var previews: some View {
 AddReminder(plant: .constant(Plant()) )
 }
 }
 */
