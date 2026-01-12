//
//  DeleteReminder.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 8/4/25.
//

import UserNotifications
import _SwiftData_SwiftUI
import SwiftUI

func cancelNotification (identifer: String){
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifer])
    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifer])
}



func cleanupExpiredReminders(plant: Plant) {
    let now = Date()
    plant.reminders.removeAll {
        Calendar.current.compare($0.date, to: now, toGranularity: .minute) == .orderedAscending
    }
        
    
}
