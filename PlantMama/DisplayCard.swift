//
//  DisplayCard.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/12/25.
//

import SwiftUI

struct DisplayCard: View {
    var imageModel: ImageModel? //need to use this eventually
    let plant: Plant
    
    var isEditing: Bool = false
    
  
    
    var body: some View {
        let imageName = ImageModel(fileName: plant.profilePic,location: .resources)
        
        ZStack(alignment: .bottom) {
            if !isEditing, let url = imageName.url {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 20, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    Text("Loading Image...")
                        .modifier(FontStyle(size: 12))
                }
                
            }
            
            ZStack(alignment: .center){
                
                RoundedRectangle(cornerRadius: 20.0)
                    .aspectRatio(5, contentMode: ContentMode.fit)
                    .foregroundColor(.white)
                    .opacity(0.9)
                
                Text(plant.name)
                    .font(.title)
                    .fontWeight(.semibold)
                
            }.padding()
        }
    }
}

struct ImageModel: Codable {
    
    enum Location: String, Codable {
        case resources, documents
    }
    var fileName: String?
    var location = Location.documents
    
    var url: URL? {
        if location == .resources {
            if let jpegImage = Bundle.main.url(forResource: fileName, withExtension: "jpeg") {
                return jpegImage
            } else {
                return Bundle.main.url(forResource: fileName, withExtension: "png")
            }
        } else {
            guard let fileName else {
                return nil
            }
            let documentDirectory = FileManager.default.documentDirectory
            return documentDirectory.appendingPathComponent(fileName)
        }
        
    }
}

#Preview {
    let plant = Plant.sampleData[0]
    DisplayCard(plant: plant)
}
