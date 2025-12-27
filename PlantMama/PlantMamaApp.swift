//
//  PlantMamaApp.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/3/25.
//

import SwiftUI
import SwiftData

typealias Plant = PlantSchemaV2.Plant
typealias Photo = PlantSchemaV2.Photo
typealias Note = PlantSchemaV2.Note
typealias Reminder = PlantSchemaV2.Reminder

@main
struct PlantMamaApp: App {
    //@StateObject private var plantData = PlantData()
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Plant.self, Photo.self, Note.self, Reminder.self,
                                           migrationPlan: AppMigrationPlan.self)
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
