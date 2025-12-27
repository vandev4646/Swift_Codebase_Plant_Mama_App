//
//  Plant.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/28/25.
//

import SwiftUI
import SwiftData

extension PlantSchemaV2 {
    @Model
    class Plant: Identifiable, Hashable {
        var id: UUID
        var name: String
        var profilePic: PlantSchemaV2.Photo
        var datePurChased: Date
        var type: String
        @Attribute(originalName: "notes") var details: String
        @Relationship(deleteRule: .cascade, inverse: \PlantSchemaV2.Reminder.plant)
        var reminders : [PlantSchemaV2.Reminder] = []
        @Relationship(deleteRule: .cascade, inverse: \PlantSchemaV2.Photo.plant)
        var photos : [PlantSchemaV2.Photo] = []
        var noteList: [PlantSchemaV2.Note] = []
        
        init(id: UUID = UUID(), name: String, profilePic: PlantSchemaV2.Photo, datePurChased: Date = Date(), type: String, details: String, reminders: [PlantSchemaV2.Reminder], photos: [PlantSchemaV2.Photo], noteList: [PlantSchemaV2.Note]) {
            self.id = id
            self.name = name
            self.profilePic = profilePic
            self.datePurChased = datePurChased
            self.type = type
            self.details = details
            self.reminders = reminders
            self.photos = photos
            self.noteList = noteList
        }
    }
}

//OLD DATA SCHEMA
extension PlantSchemaV1 {
    @Model
    class Plant: Identifiable, Hashable {
        var id: UUID
        var name: String
        var profilePic: PlantSchemaV1.Photo
        var datePurChased: Date
        var type: String
        var notes: String
        @Relationship(deleteRule: .cascade, inverse: \Reminder.plant)
        var reminders : [Reminder] = []
        @Relationship(deleteRule: .cascade, inverse: \PlantSchemaV1.Photo.plant)
        var photos : [PlantSchemaV1.Photo] = []
        
        init(id: UUID = UUID(), name: String, profilePic: PlantSchemaV1.Photo, datePurChased: Date = Date(), type: String, notes: String, reminders: [Reminder], photos: [PlantSchemaV1.Photo]) {
            self.id = id
            self.name = name
            self.profilePic = profilePic
            self.datePurChased = datePurChased
            self.type = type
            self.notes = notes
            self.reminders = reminders
            self.photos = photos
        }
    }
}




