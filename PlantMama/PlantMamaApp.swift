//
//  PlantMamaApp.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/3/25.
//

import SwiftUI
import SwiftData

typealias Plant = PlantSchemaV3.Plant
typealias Photo = PlantSchemaV3.Photo
typealias Note = PlantSchemaV3.Note
typealias Reminder = PlantSchemaV3.Reminder

@main
struct PlantMamaApp: App {
    //@StateObject private var plantData = PlantData()
    let container: ModelContainer
    
    init() {
        do {
            // 1. Define the current schema explicitly
            let schema = Schema([
                PlantSchemaV3.Plant.self,
                PlantSchemaV3.Photo.self,
                PlantSchemaV3.Note.self,
                PlantSchemaV3.Reminder.self
            ])
            
            // 2. Configure the storage
            let config = ModelConfiguration(schema: schema)
            
            // 3. Initialize with the explicit schema and migration plan
            container = try ModelContainer(
                for: schema,
                migrationPlan: AppMigrationPlan.self,
                configurations: [config]
            )
        } catch {
            fatalError("Failed to initialize Model Container: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .modelContainer(container)
        }
    }
}
