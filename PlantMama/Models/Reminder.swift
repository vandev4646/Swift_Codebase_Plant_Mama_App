//
//  PlantReminder.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/28/25.
//

import SwiftUI
import SwiftData

//WARNING: DO NOT UPDATE THIS FILE

extension PlantSchemaV1 {
    @Model
    class Reminder {
        @Attribute(.unique) var id: UUID
        var title: String
        var date: Date
        
        var plant: PlantSchemaV1.Plant?
        
        var frequency: Frequency
        var monthlyInterval: Int
        var lastUpdated: Date = Date()
        var syncState: SyncState = SyncState.NOT_SYNCED
        
        init(
            id: UUID = UUID(),
            title: String,
            date: Date,
            frequency: Frequency,
            monthlyInterval: Int = 1
        ) {
            self.id = id
            self.title = title
            self.date = date
            self.frequency = frequency
            self.monthlyInterval = monthlyInterval
        }
    }
}

