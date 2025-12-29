//
//  Photo.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/8/25.
//

import SwiftUI
import SwiftData

extension PlantSchemaV3 {
    @Model
    class Photo: Identifiable, Hashable{
        var id: UUID
        var fileName: String = ""
        var url: URL {
                if fileName.hasPrefix("bundle://") {
                    // Logic for Bundle images
                    let resourceName = fileName.replacingOccurrences(of: "bundle://", with: "")
                    return Bundle.main.url(forResource: resourceName, withExtension: "png")!
                } else {
                    // Logic for Sandbox images (reconstructed dynamically)
                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    return documentsURL.appendingPathComponent(fileName)
                }
            }
        var plant: Plant?
        var notes: [Note]?
        
        init(id: UUID = UUID(), fileName: String) {
            self.id = id
            self.fileName = fileName
        }
    }
    
    
}

extension PlantSchemaV3.Photo: Equatable {
    static func ==(lhs: PlantSchemaV3.Photo, rhs: PlantSchemaV3.Photo) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}

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




