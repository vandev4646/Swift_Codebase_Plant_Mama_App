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
    
    
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    
    var body: some View {
       // GeometryReader {
       //     geo in
            NavigationStack {
                ZStack{
                    //CardBackground()
                    //HomeTabView(selection: $selectedSideMenuTab)
                    TabView(selection: $selectedSideMenuTab) {
                        
                        DefaultView()
                            .tabItem {
                                        Label("Home", systemImage: "house")
                                    }
                            .tag(0)
                        AllReminders()
                            .tabItem {
                                        Label("Reminders", systemImage: "bell")
                                    }
                            .tag(2)
                        DefaultView()
                             .tabItem {
                                         Label("Add Plant", systemImage: "plus")
                                     }
                             .tag(1)
                    }
                    .onChange(of: selectedSideMenuTab) { newValue in
                        if newValue == 1 {
                            isAddingNewPlant = true
                            selectedSideMenuTab = 0
                        }
                    }
                    SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
                }
                
                .toolbar {ToolbarItem {
                    
                    Button{
                        presentSideMenu.toggle()
                    } label: {
                        Image(systemName: "filemenu.and.selection")
                            .fontWeight(.bold)
                            .foregroundColor(.dotBrown)
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
                
            }.tint(Color(.dotBrown)).bold()
        
    }
}


struct DisplayRow: View {
    @Query(sort: \Plant.name) private var plants: [Plant]
    let columnLayout = Array(repeating: GridItem(.flexible()), count: 2)
    var body: some View {
        if(plants.isEmpty){
            ContentUnavailableView("No plants have been added yet", systemImage: "apple.meditate.square.stack", description: Text("Click on the plus icon in the upper right corner to add your first plant."))
        } else{
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
}


struct DefaultView: View {
    var body: some View {
            VStack(alignment: .leading) {
                PlantMamaAppTitle()
                DisplayRow()
            }.background(
                Image("MenuBackground")
                    .resizable()
                    .modifier(BackgroundStyle())
        )
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
