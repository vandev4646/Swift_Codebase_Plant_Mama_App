//
//  PlantMamaApp.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/3/25.
//

import SwiftUI
import SwiftData

typealias Plant = PlantSchemaV4.Plant
typealias Photo = PlantSchemaV4.Photo
typealias Note = PlantSchemaV4.Note
typealias Reminder = PlantSchemaV4.Reminder

@main
struct PlantMamaApp: App {
    //@StateObject private var plantData = PlantData()
    let container: ModelContainer
    
    init() {
    
        //UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Color(.dotBrown)]
        //UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Color(.dotBrown)]

        do {
            // 1. Define the current schema explicitly
            let schema = Schema([
                PlantSchemaV4.Plant.self,
                PlantSchemaV4.Photo.self,
                PlantSchemaV4.Note.self,
                PlantSchemaV4.Reminder.self
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
