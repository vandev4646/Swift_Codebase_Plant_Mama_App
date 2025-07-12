//
//  PlantMamaApp.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/3/25.
//

import SwiftUI
import SwiftData

@main
struct PlantMamaApp: App {
    //@StateObject private var plantData = PlantData()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .modelContainer(for: Plant.self)
            
        }
    }
}
