/*
 COPIED FROM CAPTURING PHOTOS IOS SAMPLE APP
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI
import Photos

struct PhotoDetail: View {
    var plant: Plant
    @State var photo: Photo
    @Environment(\.dismiss) var dismiss
    private let imageSize = CGSize(width: 1024, height: 1024)
    @State private var showNotes = false
    
    var body: some View {
        Group {
            AsyncImage(url: photo.url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ZStack{
                    let url = Bundle.main.url(forResource: "Default", withExtension: "png")
                    AsyncImage(url: url){
                        image in image
                            .image?.resizable()
                            .scaledToFit()
                    }
                    ProgressView()
                }
                
            }
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
                }
            }
        }
    }
    
    func buttonsView() -> some View {
        HStack(spacing: 60) {

            Button {
                Task {
                    FileManager.default.removeItemFromDocumentDirectory(url: photo.url)
                    plant.photos.removeAll { $0.id == photo.id }
                    await MainActor.run {
                        dismiss()
                    }
                }
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


