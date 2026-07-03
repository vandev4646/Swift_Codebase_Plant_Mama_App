//
//  Photo.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/8/25.
//

import SwiftUI
import SwiftData
import Photos

//WARNING: DO NOT UPDATE THIS FILE

extension PlantSchemaV1 {
    @Model
    class Photo {
        @Attribute(.unique) var id: UUID
        var identifier: String = ""
        var plant: PlantSchemaV1.Plant?
        var notes: [PlantSchemaV1.Note] = []
        var lastUpdated: Date = Date()
        var syncState: SyncState = SyncState.NOT_SYNCED
        
        init(id: UUID = UUID(), identifier: String) {
            self.id = id
            self.identifier = identifier
        }
        @Transient var image: UIImage? {
            // 1. Locate the Documents directory
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return nil
            }
            
            // 2. Point to the "plant mama" folder and the specific file name
            let fileURL = documentsDirectory
                .appendingPathComponent("Plant Mama", isDirectory: true)
                .appendingPathComponent(identifier)
            
            // 3. Load the data and convert it back to a UIImage
            if let data = try? Data(contentsOf: fileURL) {
                return UIImage(data: data)
            }
            
            else {return nil}
            
        }
        
    }
}
