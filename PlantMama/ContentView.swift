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
    
    @State private var isAddingNewPlant = false
    // var newPlant: Plant = Plant(name: "", profilePic: Photo(url: Bundle.main.url(forResource: "Default", withExtension: "png")!), type: "", notes: "", reminders: [], photos: [])
    @Query(sort: \Reminder.date) var reminders: [Reminder]
    
    
    var body: some View {
       // GeometryReader {
       //     geo in
            NavigationStack {
                VStack(alignment: .leading) {
                    PlantMamaAppTitle()
                    
                    DisplayRow()
                        
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
       // }
        
       //
        
    }
}


struct PlantMamaAppTitle: View {
    var body: some View {
        Text("Plant Mama")
            .modifier(FontStyle(size: 50))
            .padding()
    }
}

struct DisplayRow: View {
    @Query(sort: \Plant.name) private var plants: [Plant]
    let columnLayout = Array(repeating: GridItem(.flexible()), count: 2)
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columnLayout) {
                
                
                ForEach(plants, id: \.self) {
                    plant in
                    GeometryReader { geo in
                        NavigationLink(destination: PlantEditor(plant: plant)){
                            DisplayCard(plant: plant, size: geo.size.width)
                            
                        }
                    }.cornerRadius(8.0)
                        .aspectRatio(1, contentMode: .fit)
                    .buttonStyle(.plain)
                    
                }.modifier(ListRowStyle())
                
                
                
            }.modifier(EntryListStyle())
        }.padding(10)
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
