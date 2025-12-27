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
              profilePic:  Photo(url: Bundle.main.url(forResource: "Default", withExtension: "png")!),
             type: "Fiddle Leaf Fig",
             details: "One of the first plants I ever bought!",
             reminders: [
                Reminder(title: "Pot me!", detail: "Reminder Detail", date: Date()),
                Reminder(title: "Water me!", detail: "Reminder Detail", date: Date())
             ],
              photos: [
                Photo(url: Bundle.main.url(forResource: "Peony", withExtension: "jpeg")!),
                Photo(url: Bundle.main.url(forResource: "WhiteRose", withExtension: "jpeg")!),
              ],
              noteList:[]),
        Plant(name: "Zoe",
              profilePic: Photo(url: Bundle.main.url(forResource: "Peony", withExtension: "jpeg")!),
              type: "Fiddle Leaf Fig",
              details: "Matthew purchased for me",
              reminders: [
                 Reminder(title: "Pot me!", detail: "Reminder Detail", date: Date()),
                 Reminder(title: "Water me!", detail: "Reminder Detail", date: Date())
              ]
              ,
              photos: [
                Photo(url: Bundle.main.url(forResource: "WhiteRose", withExtension: "jpeg")!),
                Photo(url: Bundle.main.url(forResource: "Default", withExtension: "png")!)
              ], noteList:[]),
        Plant(name: "Aloe",
              profilePic: Photo(url: Bundle.main.url(forResource: "WhiteRose", withExtension: "jpeg")!),
              type: "Aloe Vera",
              details: "A gift from Donna",
              reminders: [
                 Reminder(title: "Trim leaves", detail: "Reminder Detail", date: Date()),
                 Reminder(title: "Pot me!", detail: "Reminder Detail",  date: Date()),
                 Reminder(title: "Water me!", detail: "Reminder Detail", date: Date())
              ],
              photos: [
                Photo(url: Bundle.main.url(forResource: "Default", withExtension: "png")!),
                Photo(url: Bundle.main.url(forResource: "Peony", withExtension: "jpeg")!),
                Photo(url: Bundle.main.url(forResource: "WhiteRose", withExtension: "jpeg")!),
                Photo(url: Bundle.main.url(forResource: "Default", withExtension: "png")!)
              ], noteList:[]
             )
    ]
}

