/*
 COPIED MOST FROM CAPTURING ImageGalleryApp IOS SAMPLE APP
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var plant: Plant
    var updatingProfile: Bool
    @Binding var profilePic: Photo
    @Binding var addingNote: Note?
   // @EnvironmentObject var dataModel: DataModel
    
    init(
            plant: Binding<Plant>,
            updatingProfile: Bool,
            profilePic: Binding<Photo>,
            addingNote: Binding<Note?> = .constant(nil) // Default value here
        ) {
            self._plant = plant
            self.updatingProfile = updatingProfile
            self._profilePic = profilePic
            self._addingNote = addingNote
        }
    
    /// A dismiss action provided by the environment. This may be called to dismiss this view controller.
    @Environment(\.dismiss) var dismiss
    
    /// Creates the picker view controller that this object represents.
    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> PHPickerViewController {
        
        // Configure the picker.
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        // Limit to images.
        configuration.filter = .images
        // Avoid transcoding, if possible.
        configuration.preferredAssetRepresentationMode = .current

        let photoPickerViewController = PHPickerViewController(configuration: configuration)
        photoPickerViewController.delegate = context.coordinator
        return photoPickerViewController
    }
    
    /// Creates the coordinator that allows the picker to communicate back to this object.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    /// Updates the picker while it’s being presented.
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<PhotoPicker>) {
        // No updates are necessary.
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    var parent: PhotoPicker
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        self.parent.dismiss()
        
        guard let result = results.first,
              result.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) else { return }
        
        result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
            if let url = url {
                // 1. Generate a unique name for the file
                let newFileName = "photo_\(UUID().uuidString).jpg"
                
                // 2. Get the current Documents directory
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let destinationURL = documentsURL.appendingPathComponent(newFileName)
                
                do {
                    // 3. Copy the file to the new location
                    try FileManager.default.copyItem(at: url, to: destinationURL)
                    
                    // 4. Save ONLY the filename to SwiftData
                    Task { @MainActor in
                        withAnimation {
                            let newPhoto = Photo(fileName: newFileName)
                            self.parent.plant.photos.append(newPhoto)
                            
                            if self.parent.updatingProfile {
                                self.parent.plant.profilePic = newPhoto
                                self.parent.profilePic = newPhoto
                            }
                            if let currentNote = self.parent.addingNote {
                                        // Check if the photos array itself is nil
                                        if currentNote.photos == nil {
                                            currentNote.photos = [newPhoto] // Initialize with the first photo
                                        } else {
                                            currentNote.photos?.append(newPhoto) // Append if already exists
                                        }
                            }
                        }
                    }
                } catch {
                    print("Failed to save image: \(error)")
                }
            }
        }
    }

    
    /*
    /// Called when one or more items have been picked, or when the picker has been canceled.
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        // Dismisss the presented picker.
        self.parent.dismiss()
        
        guard
            let result = results.first,
            result.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier)
        else { return }
        
        // Load a file representation of the picked item.
        // This creates a temporary file which is then copied to the app’s document directory for persistent storage.
        result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
            if let error = error {
                print("Error loading file representation: \(error.localizedDescription)")
            } else if let url = url {
                if let savedUrl = FileManager.default.copyItemToDocumentDirectory(from: url) {
                    // Add the new item to the data model.
                    /*
                    Task { @MainActor [dataModel = self.parent.dataModel] in
                        withAnimation {
                            //let item = Item(url: savedUrl)
                          //  dataModel.addItem(item)
                            
                        }
                    }*/
                    
                    Task {
                        @MainActor [plant = self.parent.plant, updatingProfile = self.parent.updatingProfile] in
                        withAnimation {
                            plant.photos.append(Photo(url: savedUrl))
                            if (updatingProfile){
                                let photo = Photo(url: savedUrl)
                                plant.profilePic = photo
                                self.parent.profilePic = photo
                                
                            }
                        }
                    }
                    
                }
            }
     
        }
        
        //////
     
    }
     */
    
    init(_ parent: PhotoPicker) {
        self.parent = parent
    }
}

