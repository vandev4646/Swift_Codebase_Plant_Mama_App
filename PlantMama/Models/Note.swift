//
//  Note.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 12/24/25.
//

import SwiftUI
import SwiftData

extension PlantSchemaV2{
    @Model
    class Note: Identifiable, Hashable {
        var id: UUID
        var title: String
        var date: Date
        var plant: PlantSchemaV2.Plant?
        var photos: [Photo]?
        
        init(id: UUID = UUID(), title: String, date: Date) {
            self.id = id
            self.title = title
            self.date = date
        }
    }
}
