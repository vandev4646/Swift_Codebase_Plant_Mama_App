//
//  FilesAppStorageManager.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 7/2/26.
//

import UIKit

class FilesAppStorageManager {
    
    /// Retrieves or creates the public "plant mama" subfolder visible in the Files App
    static func getPlantMamaFolderURL() -> URL? {
        let fileManager = FileManager.default
        
        // Locates the base "Documents" directory (mirrored as your App Folder in Files app)
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        // Names the target subfolder
        let folderURL = documentsDirectory.appendingPathComponent("Plant Mama", isDirectory: true)
        
        // Creates the folder physically if it is missing
        if !fileManager.fileExists(atPath: folderURL.path) {
            do {
                try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating Files app directory: \(error)")
                return nil
            }
        }
        
        return folderURL
    }
    
    /// Saves a raw UIImage into the public Files App folder and returns the unique filename string
    static func saveToFilesApp(image: UIImage) -> String? {
        guard let folderURL = getPlantMamaFolderURL() else { return nil }
        
        // Generate a random, clean unique file name
        let fileName = "\(UUID().uuidString).jpg"
        let fileURL = folderURL.appendingPathComponent(fileName)
        
        // Compress the image data (JPEG format, 80% fidelity)
        guard let data = image.jpegData(compressionQuality: 0.80) else {
            return nil
        }
        
        do {
            try data.write(to: fileURL)
            print("Successfully exposed photo to Files App at: \(fileURL.path)")
            return fileName // Return this to save as your Photo.identifier
        } catch {
            print("Failed writing image data to public Files app folder: \(error)")
            return nil
        }
    }
    
    static func deletePhotoFromFolder(photo: Photo) {
        let fileManager = FileManager.default
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            // Locate the exact file inside the "plant mama" folder
            let fileURL = documentsDirectory
                .appendingPathComponent("Plant Mama", isDirectory: true)
                .appendingPathComponent(photo.identifier)
            
            // Verify the file exists on disk before attempting to delete it
            if fileManager.fileExists(atPath: fileURL.path) {
                do {
                    try fileManager.removeItem(at: fileURL)
                    print("Successfully deleted physical image file from Files App: \(photo.identifier)")
                } catch {
                    print("Error removing file from disk: \(error.localizedDescription)")
                }
            }
        }
    }
}
