//
//  AppMigrationPlan.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 12/25/25. Inspired by Google's Auto AI summary
//

import SwiftData

enum AppMigrationPlan: SchemaMigrationPlan {
    // 1. List all versions in order from oldest to newest
    static var schemas: [any VersionedSchema.Type] {
        [PlantSchemaV1.self, PlantSchemaV2.self, PlantSchemaV3.self]
    }
    
    // 2. Define the stages of migration
    static var stages: [MigrationStage] {
        [migrateV1toV2, migrateV2toV3]
    }
    
    // 3. Define the specific logic for the V1 to V2 move
    static let migrateV1toV2 = MigrationStage.lightweight(
        fromVersion: PlantSchemaV1.self,
        toVersion: PlantSchemaV2.self
    )
    
    static let migrateV2toV3 = MigrationStage.custom(
        fromVersion: PlantSchemaV2.self,
        toVersion: PlantSchemaV3.self,
        willMigrate: { context in
            // 1. Fetch all existing photos from the V2 schema
            let photos = try context.fetch(FetchDescriptor<PlantSchemaV2.Photo>())
            
            for photo in photos {
                // 2. Extract the string filename from the old URL
                let oldURL = photo.url
                let extractedName = oldURL.lastPathComponent
                
                // 3. Update the V2 object's 'url' won't work for the V3 'fileName'
                // SwiftData handles the structural move; you use 'willMigrate'
                // for data cleanup or logic that must happen BEFORE the schema officially swaps.
            }
            try context.save()
        },
        didMigrate: nil
    )

}
