//
//  Plant.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/28/25.
//

import SwiftUI
import SwiftData

//WARNING: DO NOT UPDATE THIS FILE

extension PlantSchemaV1 {
    @Model
    class Plant {
        @Attribute(.unique) var id: UUID
        var name: String
        
       var profilePic: PlantSchemaV1.Photo
        
        var datePurchased: Date
        var type: String
        var details: String
        
        @Relationship(deleteRule: .cascade, inverse: \PlantSchemaV1.Reminder.plant)
        var reminders: [PlantSchemaV1.Reminder] = []
        
        @Relationship(deleteRule: .cascade, inverse: \PlantSchemaV1.Photo.plant)
        var photos: [PlantSchemaV1.Photo] = []
        
        @Relationship(deleteRule: .cascade, inverse: \PlantSchemaV1.Note.plant)
        var noteList: [PlantSchemaV1.Note] = []
        
        var lastUpdated: Date = Date()
        var syncState: SyncState = SyncState.NOT_SYNCED
        
        init(
            id: UUID = UUID(),
            name: String,
            profilePic: Photo,
            datePurchased: Date = Date(),
            type: String,
            details: String
        ) {
            self.id = id
            self.name = name
            self.profilePic = profilePic
            self.datePurchased = datePurchased
            self.type = type
            self.details = details
        }
    }
}


