/*
 COPIED FROM CAPTURING PHOTOS IOS SAMPLE APP
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI
import Photos

struct PhotoDetail: View {
    var plant: Plant?
    @State var photo: Photo
    @Environment(\.dismiss) var dismiss
    private let imageSize = CGSize(width: 1024, height: 1024)
    @State private var showNotes = false
    var type: PhotoDeleteType
    @Environment(\.modelContext) private var context
    @State private var showingDeleteConfirmation = false
    @State private var showingDeleteError = false
    
    var body: some View {
        Group {
            LibraryImage(identifier: photo.identifier)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.secondary)
        .navigationTitle("Photo")
        .navigationBarTitleDisplayMode(.inline)
        .overlay(alignment: .bottom) {
            buttonsView()
                .offset(x: 0, y: -50)
        }
        .sheet(isPresented: $showNotes){
            noteSheet
        }
        .confirmationDialog("Are you sure?", isPresented: $showingDeleteConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                Task {
                    let result = deletePhoto(photo: photo, type: type, context: context)
                    if result == -1 {
                                showingDeleteError = true
                            } else {
                                dismiss()
                            }
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            if type == .all {
                Text("If you delete this photo it will be deleted from all plants and notes it is associated with.")
            } else {
                Text("Are you sure you want to delete this photo?")
            }
        }
        .alert("Cannot Delete Photo", isPresented: $showingDeleteError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("This photo is the plant's profile picture. You cannot delete a photo if it is a current profile picture. Change the profile picture before deleting this photo.")
        }

    }
    
    private var noteSheet: some View {
        NavigationStack{
            List{
                if let notes = photo.notes, !notes.isEmpty {
                    ForEach(notes) { note in
                        VStack(alignment: .leading,){
                            Text(note.title)
                                .font(.headline)
                        }
                    }.padding(.vertical, 4)
                }
                else{
                    ContentUnavailableView("No Notes", systemImage: "note.text", description: Text("Go to the notes section to add a note for this photo."))
                }
            }
            .navigationTitle("Photo Notes")
            .toolbar{
                Button("Done"){
                    showNotes = false
                }.tint(Color(.dotBrown))
            }
        }
    }
    
    func buttonsView() -> some View {
        HStack(spacing: 60) {
                Button {
                    showingDeleteConfirmation = true
                } label: {
                    Label("Delete", systemImage: "trash")
                        .font(.system(size: 24))
                }
                
                Button {
                    showNotes = true
                } label: {
                    Label("Note", systemImage: "info.circle")
                        .font(.system(size: 24))
                }
        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
        .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
        .background(Color.secondary.colorInvert())
        .cornerRadius(15)
    }
}


