/*
 COPIED FROM CAPTURING PHOTOS IOS SAMPLE APP
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct CameraView: View {
    @StateObject private var model = DataModel()
    @Binding var plant: Plant
    private static let barHeightFactor = 0.15
    @Environment(\.dismiss) var dismiss
    var updatingProfile: Bool
    @Binding var profilePic: Photo
    @Binding var addingNote: Note?
    
    init(
            plant: Binding<Plant>,
            profilePic: Binding<Photo>,
            updatingProfile: Bool,
            addingNote: Binding<Note?> = .constant(nil) // Default value
        ) {
            // Initialize StateObject
            self._model = StateObject(wrappedValue: DataModel())
            
            // Initialize Bindings (using underscore to access the Binding itself)
            self._plant = plant
            self._profilePic = profilePic
            self._addingNote = addingNote
            
            // Initialize standard property
            self.updatingProfile = updatingProfile
        }
    
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geometry in
                ViewfinderView(image:  $model.viewfinderImage )
                    .overlay(alignment: .top) {
                        Color.black
                            .opacity(0.75)
                            .frame(height: geometry.size.height * Self.barHeightFactor)
                    }
                    .overlay(alignment: .bottom) {
                        buttonsView()
                            .frame(height: geometry.size.height * Self.barHeightFactor)
                            .background(.black.opacity(0.75))
                    }
                    .overlay(alignment: .center)  {
                        Color.clear
                            .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                            .accessibilityElement()
                            .accessibilityLabel("View Finder")
                            .accessibilityAddTraits([.isImage])
                    }
                    .background(.black)
            }
            .task {
                await model.camera.start()
                await model.loadPhotos()
                await model.loadThumbnail()
            }
            .navigationTitle("Camera")
            .navigationBarTitleDisplayMode(.inline)
            //.navigationBarHidden(true)
            .ignoresSafeArea()
            .statusBar(hidden: true)
        }
    }
    
    private func buttonsView() -> some View {
            HStack(spacing: 60) {
            
            Spacer()

            NavigationLink {
                if self.addingNote == nil {
                    PhotoPicker(plant:$plant, updatingProfile: updatingProfile, profilePic: $profilePic)
                        .onAppear {
                            model.camera.isPreviewPaused = true
                        }
                        .onDisappear {
                            dismiss()
                        }
                }
                else{
                    PhotoPicker(plant:$plant, updatingProfile: updatingProfile, profilePic: $profilePic, addingNote: self.$addingNote)
                        .onAppear {
                            model.camera.isPreviewPaused = true
                        }
                        .onDisappear {
                            dismiss()
                        }
                }
                
                
            } label: {
                Label {
                    Text("Gallery")
                } icon: {
                    ThumbnailView(image: model.thumbnailImage)
                }
            }
            
                NavigationLink {
                    if self.addingNote == nil {
                        PhotoPicker(plant:$plant, updatingProfile: updatingProfile, profilePic: $profilePic)
                            .onAppear {
                                model.camera.takePhoto()
                            }
                            .onDisappear {
                                dismiss()
                            }
                    }
                    else{
                        PhotoPicker(plant:$plant, updatingProfile: updatingProfile, profilePic: $profilePic, addingNote: self.$addingNote)
                            .onAppear {
                                model.camera.takePhoto()
                            }
                            .onDisappear {
                                dismiss()
                            }
                    }
                    
            } label: {
                Label {
                    Text("Take Photo")
                } icon: {
                    ZStack {
                        Circle()
                            .strokeBorder(.white, lineWidth: 3)
                            .frame(width: 62, height: 62)
                        Circle()
                            .fill(.white)
                            .frame(width: 50, height: 50)
                    }
                }
            }
            
            Button {
                model.camera.switchCaptureDevice()
            } label: {
                Label("Switch Camera", systemImage: "arrow.triangle.2.circlepath")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
            }
            
            Spacer()
        
        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
        .padding()
    }
    
}

