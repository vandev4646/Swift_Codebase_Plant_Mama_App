//
//  Firestore_DTO.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 7/3/26.
//

import Foundation


/*
 This file contains the data mapping class to represent Firestore data
 */

struct PlantDocument: Codable, Sendable{
    let UUID: String
    let profilePic: String
    let name: String
    let datePurchased: Date
    let type: String
    let description: String
    let lastUpdated: Date
}

struct NoteDocument: Codable, Sendable{
    let UUID: String
    let title: String
    let date: Date
    let photoRoomIds: [String]
    let lastUpdated: Date
}

struct PhotoDocument: Codable, Sendable{
    let UUID: String
    let uri: String
    let lastUpdated: Date
}

struct ReminderDocument: Codable, Sendable{
    let UUID: String
    let wmIdentifier: String
    let title: String
    let date: Date
    let frequency: String
    let interval: Int
    let lastUpdated: Date
}
