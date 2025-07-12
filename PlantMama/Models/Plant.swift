//
//  Plant.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/28/25.
//

import SwiftUI
import SwiftData

@Model
class Plant: Identifiable, Hashable {
    var id: UUID
    var name: String
    var profilePic: String
    var datePurChased: Date
    var type: String
    var notes: String
    @Relationship(deleteRule: .cascade, inverse: \Reminder.plant)
    var reminders : [Reminder] = []
    @Relationship(deleteRule: .cascade, inverse: \Photo.plant)
    var photos : [Photo] = []
    
    init(id: UUID = UUID(), name: String, profilePic: String, datePurChased: Date = Date(), type: String, notes: String, reminders: [Reminder], photos: [Photo]) {
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

