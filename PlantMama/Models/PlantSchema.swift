//
//  PlantSchemaV1.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 12/25/25.
//
import SwiftData

enum PlantSchemaV1: VersionedSchema{
    static var versionIdentifier = Schema.Version(1, 0, 0)
        static var models: [any PersistentModel.Type] {
            [Photo.self, Plant.self, Reminder.self]
        }
}

enum PlantSchemaV2: VersionedSchema{
    static var versionIdentifier = Schema.Version(2, 0, 0)
        static var models: [any PersistentModel.Type] {
            [Photo.self, Plant.self, Reminder.self, Note.self]
        }
}


