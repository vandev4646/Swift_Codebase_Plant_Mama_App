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
    
    init(_ parent: PhotoPicker) {
        self.parent = parent
    }
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        self.parent.dismiss()
        
        
        guard let result = results.first,
              let assetIdentifier = result.assetIdentifier else { return }
        
    
        let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: [assetIdentifier], options: nil)
        guard let existingAsset = fetchResult.firstObject else { return }
        
        self.getOrCreateAlbum(title: "Plant Mama") { album in
            guard let album = album else { return }
            
            PHPhotoLibrary.shared().performChanges({
                if let albumRequest = PHAssetCollectionChangeRequest(for: album) {
                    albumRequest.addAssets([existingAsset] as NSArray)
                }
            }) { success, error in
                if success {
                    Task { @MainActor in
                        withAnimation {
                            let newPhoto = Photo(identifier: assetIdentifier)
                            self.parent.plant.photos.append(newPhoto)
                            
                            if self.parent.updatingProfile {
                                newPhoto.plant = self.parent.plant
                                self.parent.plant.profilePic = newPhoto
                                self.parent.profilePic = newPhoto
                            }
                            
                            if let currentNote = self.parent.addingNote {
                                if currentNote.photos == nil {
                                    currentNote.photos = [newPhoto]
                                } else {
                                    currentNote.photos?.append(newPhoto)
                                }
                            }
                        }
                    }
                } else {
                    print("Failed to add existing asset to folder: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
    }


    
    // Helper: Finds or creates the custom album
    private func getOrCreateAlbum(title: String, completion: @escaping (PHAssetCollection?) -> Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", title)
        let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let album = collections.firstObject {
            completion(album)
        } else {
            var albumPlaceholder: PHObjectPlaceholder?
            PHPhotoLibrary.shared().performChanges({
                let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: title)
                albumPlaceholder = request.placeholderForCreatedAssetCollection
            }) { success, _ in
                if success, let placeholder = albumPlaceholder {
                    let fetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
                    completion(fetchResult.firstObject)
                } else {
                    completion(nil)
                }
            }
        }
    }



    
    
}

