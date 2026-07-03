//
//  PhotoPicker.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 3/4/26.
//

/*
 COPIED MOST FROM CAPTURING ImageGalleryApp IOS SAMPLE APP
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI
import PhotosUI
import SwiftData

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var plant: Plant
    var updatingProfile: Bool
    @Binding var profilePic: Photo
    @Binding var addingNote: Note?
    
    init(
        plant: Binding<Plant>,
        updatingProfile: Bool,
        profilePic: Binding<Photo>,
        addingNote: Binding<Note?> = .constant(nil)
    ) {
        self._plant = plant
        self.updatingProfile = updatingProfile
        self._profilePic = profilePic
        self._addingNote = addingNote
    }
    
    @Environment(\.dismiss) var dismiss
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let photoPickerViewController = PHPickerViewController(configuration: configuration)
        photoPickerViewController.delegate = context.coordinator
        return photoPickerViewController
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    

    class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
        var parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.dismiss()
            
            // Ensure the user actually picked an image
            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else { return }
            
            // Load the picked object asynchronously into memory as a UIImage
            provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                guard let self = self, let uiImage = object as? UIImage else { return }
                
                // Save the image data directly to the public "Plant Mama" Files app folder
                guard let allocatedFileName = FilesAppStorageManager.saveToFilesApp(image: uiImage) else {
                    print("Error: Failed to write picker image to Files app sandbox disk.")
                    return
                }
                
                //Update SwiftData properties and UI lists on the Main Actor
                Task { @MainActor in
                    withAnimation {
                        // Instantiate the new Photo model using the allocated local file name string
                        let newPhoto = Photo(identifier: allocatedFileName)
                        
                        // Append to the specific plant's photostream
                        self.parent.plant.photos.append(newPhoto)
                        
                        // Handle user profile picture updates
                        if self.parent.updatingProfile {
                            newPhoto.plant = self.parent.plant
                            self.parent.plant.profilePic = newPhoto
                            self.parent.profilePic = newPhoto
                        }
                        
                        // Link photo reference to an open note item if present
                        if let currentNote = self.parent.addingNote {
                            if currentNote.photos == nil {
                                currentNote.photos = [newPhoto]
                            } else {
                                currentNote.photos.append(newPhoto)
                            }
                        }
                    }
                }
            }
        }
    }
}

            

