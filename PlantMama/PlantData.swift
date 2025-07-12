//
//  PlantData.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/28/25.
//

/*
import SwiftUI

class PlantData: ObservableObject {
    @Published var plants: [Plant] = [
        Plant(name: "Sophie",
             type: "Fiddle Leaf Fig",
             notes: "One of the first plants I ever bought!",
             reminders: [
                Reminder(title: "Pot me!"),
                Reminder(title: "Water me!")
             ]),
        Plant(name: "Zoe",
              profilePic: "Peony",
              type: "Fiddle Leaf Fig",
              notes: "Matthew purchased for me",
              reminders: [
                 Reminder(title: "Pot me!"),
                 Reminder(title: "Water me!")
              ]),
        Plant(name: "Aloe",
              profilePic: "WhiteRose",
              type: "Aloe Vera",
              notes: "A gift from Donna",
              reminders: [
                 Reminder(title: "Trim leaves"),
                 Reminder(title: "Pot me!"),
                 Reminder(title: "Water me!")
              ],
              photos: [
                Photo(url: Bundle.main.url(forResource: "Default", withExtension: "png")!),
                Photo(url: Bundle.main.url(forResource: "Peony", withExtension: "jpeg")!),
                Photo(url: Bundle.main.url(forResource: "WhiteRose", withExtension: "jpeg")!),
                Photo(url: Bundle.main.url(forResource: "Default", withExtension: "png")!)
              ]
             ),
    ]
    
    func delete(_ plant: Plant) {
        plants.removeAll{ $0.id == plant.id}
    }
    
    func exists(_ plant: Plant) -> Bool {
        plants.contains(plant)
    }
    
    func addReminder(_ plant: Plant, _ reminder: Reminder) {
        
    }
    
    func sortedPlants() -> Binding<[Plant]> {
        Binding<[Plant]>(
            get: {
                self.plants
                    .sorted { $0.id < $1.id }
            },
            set: { plants in
                for plant in plants {
                    if let index = self.plants.firstIndex(where: { $0.id == plant.id }) {
                        self.plants[index] = plant
                    }
                }
            }
        )
    }
}



*/
