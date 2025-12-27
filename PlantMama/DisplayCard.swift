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
    let size: Double
    var isEditing: Bool = false
    
  
    
    var body: some View {
        //let imageName = ImageModel(fileName: plant.profilePic,location: .resources)
        
        ZStack(alignment: .bottom) {
            if !isEditing {
                AsyncImage(url: plant.profilePic.url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                    //.clipped()
                        
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    ZStack{
                        let url = Bundle.main.url(forResource: "Default", withExtension: "png")
                        AsyncImage(url: url) {
                            image in image
                                .image?.resizable()
                                .scaledToFill()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        Text("Loading Image...")
                            .modifier(FontStyle(size: 12))
                    }

                }.frame(minWidth: size, maxWidth: size , minHeight: size, maxHeight: size)
                
            }
            
            ZStack(alignment: .center){
                
                RoundedRectangle(cornerRadius: 20.0)
                    .aspectRatio(5, contentMode: ContentMode.fit)
                    .foregroundColor(.white)
                    .opacity(0.9)
                    .frame(maxWidth: size * 7/8)
                
                Text(plant.name)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.dotBrown)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                
            }.padding()
        }.frame(minWidth: size, maxWidth: size , minHeight: size, maxHeight: size)
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
            return documentDirectory?.appendingPathComponent(fileName)
        }
        
    }
}

#Preview {
    let plant = Plant.sampleData[0]
    DisplayCard(plant: plant, size: 200)
}
