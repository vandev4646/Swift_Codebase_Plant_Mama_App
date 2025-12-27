//
//  Photo.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/8/25.
//

import SwiftUI
import SwiftData


extension PlantSchemaV2 {
    @Model
    class Photo: Identifiable, Hashable{
        var id: UUID
        var url: URL
        var plant: Plant?
        var notes: [Note]?
        
        init(id: UUID = UUID(), url: URL) {
            self.id = id
            self.url = url
        }
    }
    
    
}

extension PlantSchemaV2.Photo: Equatable {
    static func ==(lhs: PlantSchemaV2.Photo, rhs: PlantSchemaV2.Photo) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}



//OLD SCHEMA DATA
extension PlantSchemaV1 {
    @Model
    class Photo: Identifiable, Hashable{
        var id: UUID
        var url: URL
        var plant: Plant?
        
        init(id: UUID = UUID(), url: URL) {
            self.id = id
            self.url = url
        }
    }
    
    
}

extension PlantSchemaV1.Photo: Equatable {
    static func ==(lhs: PlantSchemaV1.Photo, rhs: PlantSchemaV1.Photo) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}




