//
//  DeleteReminder.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 8/4/25.
//

import UserNotifications
import _SwiftData_SwiftUI
import SwiftUI

func cancelNotification (identifier: String){
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifier])
}



@MainActor func cleanupExpiredReminders(
    plant: Plant,
    context: ModelContext,
    syncManager: FirestoreSyncManager
) {
    let now = Date()
    let expiredReminders = plant.reminders.filter{ reminder in
        let isOnce = reminder.frequency == .once
        let isExpried = Calendar.current.compare(reminder.date, to: now, toGranularity: .minute) == .orderedAscending
        return isOnce && isExpried
    }
    
    for reminder in expiredReminders {
        syncManager.deleteBackupReminder(reminder: reminder, context: context)
        //remove from plant
        plant.reminders.removeAll(where: { $0.id == reminder.id})
        //delete from sift data
        context.delete(reminder)
    }
        
    
}
