//
//  PlantReminder.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/28/25.
//

import SwiftUI
import SwiftData

@Model
class Reminder: Identifiable, Hashable {
    var id: UUID
    var title: String
    var date: Date
    var plant: Plant?
    
    init(id: UUID = UUID(), title: String, date: Date) {
        self.id = id
        self.title = title
        self.date = date
    }
}

