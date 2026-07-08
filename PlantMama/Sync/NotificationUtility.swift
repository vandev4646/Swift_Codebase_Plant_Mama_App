//
//  NotificationUtility.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 7/7/26.
//

import Foundation
import UserNotifications

struct NotificationUtility {
    static let notificationCenter = UNUserNotificationCenter.current()
    
    static func scheduleNotification(title: String, body: String, date: Date, identifier: String, frequency: Frequency, interval: Int) {
        
        notificationCenter.getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                if settings.authorizationStatus == .authorized {
                    
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = body
                    
                    //let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    var dateComp: DateComponents
                    var repeats = false
                    switch frequency {
                    case .once:
                        dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                        repeats = false
                    case .daily:
                        dateComp = Calendar.current.dateComponents([.hour, .minute], from: date)
                        repeats = true
                    case .weekly:
                        dateComp = Calendar.current.dateComponents([.weekday, .hour, .minute], from: date)
                        repeats = true
                    case .monthly:
                        dateComp = Calendar.current.dateComponents([.day, .hour, .minute], from: date)
                        repeats = true
                        
                    }
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: repeats)
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
}
