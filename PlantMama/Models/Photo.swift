//
//  Photo.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/8/25.
//

import SwiftUI
import SwiftData

@Model
class Photo: Identifiable, Hashable{
    var id: UUID
    var url: URL
    var plant: Plant?
    
    init(id: UUID = UUID(), url: URL) {
        self.id = id
        self.url = url
    }
}

extension Photo: Equatable {
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
