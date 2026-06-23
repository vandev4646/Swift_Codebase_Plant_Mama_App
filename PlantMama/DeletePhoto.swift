//
//  DeletePhoto.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/11/26.
//
import _SwiftData_SwiftUI
import SwiftUI

enum PhotoDeleteType {
    case all
    case plant
}


func deletePhoto(photo: Photo, type: PhotoDeleteType, context: ModelContext) -> Int {
    if (photo.plant?.profilePic.id == photo.id){ return -1}
    if type == .all {
        photo.plant?.photos.removeAll(where: { $0.id == photo.id })
        photo.notes?.forEach { note in
            note.photos?.removeAll(where: { $0.id == photo.id })
        }
        
        context.delete(photo)
        
    }
    else{
        photo.plant?.photos.removeAll(where: { $0.id == photo.id })
    }
    return 0
}
