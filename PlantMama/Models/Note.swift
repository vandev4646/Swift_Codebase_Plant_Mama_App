//
//  Note.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 12/24/25.
//

import SwiftUI
import SwiftData


//WARNING: DO NOT UPDATE THIS FILE

extension PlantSchemaV1 {
    @Model
    class Note {
        @Attribute(.unique) var id: UUID
        var title: String
        var date: Date
        
        var plant: PlantSchemaV1.Plant?
        
        // Explicit Many-to-Many setup mapping back to Photo.notes
        @Relationship(inverse: \PlantSchemaV1.Photo.notes)
        var photos: [PlantSchemaV1.Photo] = []
        
        var lastUpdated: Date = Date()
        var syncState: SyncState = SyncState.NOT_SYNCED
        
        init(id: UUID = UUID(), title: String, date: Date = Date()) {
            self.id = id
            self.title = title
            self.date = date
        }
    }
}

