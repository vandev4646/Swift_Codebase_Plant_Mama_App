//
//  PlantReminder.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/28/25.
//

import SwiftUI
import SwiftData

extension PlantSchemaV2{
    @Model
    class Reminder: Identifiable, Hashable {
        var id: UUID
        var title: String
        var date: Date
        var plant: PlantSchemaV2.Plant?
        
        init(id: UUID = UUID(), title: String, detail: String, date: Date) {
            self.id = id
            self.title = title
            self.date = date
        }
    }
}

extension PlantSchemaV1{
    @Model
    class Reminder: Identifiable, Hashable {
        var id: UUID
        var title: String
        //var detail: String
        var date: Date
        var plant: PlantSchemaV1.Plant?
        
        init(id: UUID = UUID(), title: String, detail: String, date: Date) {
            self.id = id
            self.title = title
           // self.detail = detail
            self.date = date
        }
    }
}



