//
//  Plant+Sample.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/24/25.
//

import Foundation

extension Plant {
    static let sampleData: [Plant] =
    [
        Plant(name: "Sophie",
              profilePic: "Default",
             type: "Fiddle Leaf Fig",
             notes: "One of the first plants I ever bought!",
             reminders: [
                Reminder(title: "Pot me!", date: Date()),
                Reminder(title: "Water me!", date: Date())
             ],
              photos: [
                Photo(url: Bundle.main.url(forResource: "Peony", withExtension: "jpeg")!),
                Photo(url: Bundle.main.url(forResource: "WhiteRose", withExtension: "jpeg")!),
              ]),
        Plant(name: "Zoe",
              profilePic: "Peony",
              type: "Fiddle Leaf Fig",
              notes: "Matthew purchased for me",
              reminders: [
                 Reminder(title: "Pot me!", date: Date()),
                 Reminder(title: "Water me!", date: Date())
              ]
              ,
              photos: [
                Photo(url: Bundle.main.url(forResource: "WhiteRose", withExtension: "jpeg")!),
                Photo(url: Bundle.main.url(forResource: "Default", withExtension: "png")!)
              ]),
        Plant(name: "Aloe",
              profilePic: "WhiteRose",
              type: "Aloe Vera",
              notes: "A gift from Donna",
              reminders: [
                 Reminder(title: "Trim leaves", date: Date()),
                 Reminder(title: "Pot me!", date: Date()),
                 Reminder(title: "Water me!", date: Date())
              ],
              photos: [
                Photo(url: Bundle.main.url(forResource: "Default", withExtension: "png")!),
                Photo(url: Bundle.main.url(forResource: "Peony", withExtension: "jpeg")!),
                Photo(url: Bundle.main.url(forResource: "WhiteRose", withExtension: "jpeg")!),
                Photo(url: Bundle.main.url(forResource: "Default", withExtension: "png")!)
              ]
             )
    ]
}
