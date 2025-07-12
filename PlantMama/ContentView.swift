//
//  ContentView.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/3/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //@EnvironmentObject var plantData: PlantData
    @Query(sort: \Plant.name) private var plants: [Plant]
    let columnLayout = Array(repeating: GridItem(), count: 2)
    @State private var isAddingNewPlant = false
     var newPlant: Plant = Plant(name: "", profilePic: "Default", type: "", notes: "", reminders: [], photos: [])
    
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading) {
                PlantMamaAppTitle()
                
                ScrollView {
                    LazyVGrid(columns: columnLayout) {
                        ForEach(plants, id: \.self) { plant in
                            NavigationLink{
                                PlantEditor(plant: plant)
                                
                            } label: {
                                DisplayCard(plant: plant)
                                
                            }
                            .buttonStyle(.plain)
                            
                        }.modifier(ListRowStyle())
                    }.modifier(EntryListStyle())
                }.padding(10)
                    
            }
            //.navigationTitle("Plant Mama")
            .toolbar {ToolbarItem {
                Button {
                    isAddingNewPlant = true
                } label: {
                    Image(systemName: "plus")
                }
                }
            }
            .sheet(isPresented: $isAddingNewPlant) {
                NewPlantSheet()
            }
            .background(
                    Image("MenuBackground")
                        .resizable()
                        .modifier(BackgroundStyle())
            )
        }
        
        
    }
}


struct PlantMamaAppTitle: View {
    var body: some View {
        Text("Plant Mama")
            .modifier(FontStyle(size: 50))
            .padding()
    }
}

#Preview(traits: .plantSampleData) {
    ContentView()
}
/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 NavigationView {
 ContentView().environmentObject(PlantData())
 
 }
 }
 }
 /**/*/
