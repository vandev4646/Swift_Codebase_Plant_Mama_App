//
//  AddReminder.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/16/25.
// Got inspiration from this github: https://github.com/codeWithCal/NotificationsTutorialSwift/blob/main/NotificationsTutorial/ViewController.swift
//

import SwiftUI
import UserNotifications

struct AddReminder: View {
    let plant: Plant
    @State private var reminder = Reminder(title: "", detail: "", date: Date())
    @Binding var addingReminder: Bool
    @State var permissionDenied = false
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    
    var body: some View {
        List {
            VStack (alignment: .center) {
                TextField("Reminder Details", text: $reminder.title).font(.title2)
                DatePicker("Date", selection: $reminder.date)
                    .labelsHidden()
                    .listRowSeparator(.hidden)
                
            }.padding()
            
            Button(action: {
                plant.reminders.append(reminder)
                scheduleNotification(title: plant.name + "'s" + " reminder", body: reminder.title, date: reminder.date, identifier: reminder.id.uuidString)
                addingReminder.toggle()
            }, label: {Label("Add Reminder", systemImage: "plus")}).disabled(permissionDenied || reminder.title.isEmpty)
           
            if(permissionDenied){
                Text("To use this feature you must enable notifications in settings!").padding().foregroundStyle(.red).bold()
            }
            
        }.onAppear() {
            notificationCenter.requestAuthorization(options: [.alert, .sound]) {
                (permissionGranted, error) in
                            if(!permissionGranted)
                            {
                                permissionDenied = !permissionGranted
                                print("Permission Denied")
                            }
            }
        }
       
        
        
    }
    
    func scheduleNotification(title: String, body: String, date: Date, identifier: String) {
        
        notificationCenter.getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                if settings.authorizationStatus == .authorized {
               
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = body
                    
                    let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                    
                    self.notificationCenter.add(request) { (error) in
                                            if(error != nil)
                                            {
                                                print("Error " + error.debugDescription)
                                                return
                                            }
                                        }
                }
                
            }
        }
        
        
        
    }
    
    func formattedDate(date: Date) -> String
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM y HH:mm"
            return formatter.string(from: date)
        }
}



/*
 struct AddReminder_Previews: PreviewProvider {
 static var previews: some View {
 AddReminder(plant: .constant(Plant()) )
 }
 }
 */
