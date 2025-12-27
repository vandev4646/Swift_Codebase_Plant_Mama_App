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
        [PlantSchemaV1.self, PlantSchemaV2.self]
    }
    
    // 2. Define the stages of migration
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    // 3. Define the specific logic for the V1 to V2 move
    static let migrateV1toV2 = MigrationStage.lightweight(
        fromVersion: PlantSchemaV1.self,
        toVersion: PlantSchemaV2.self
    )
}
