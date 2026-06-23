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
    @State private var showInfo = false
    
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
                            .tag(1)
                        AllPhotos()
                            .tabItem{
                                Label("Photos", systemImage: "photo.on.rectangle.angled.fill")
                            }
                            .tag(2)
                        DefaultView()
                             .tabItem {
                                         Label("Add Plant", systemImage: "plus")
                                     }
                             .tag(3)
                    }
                    .onChange(of: selectedSideMenuTab) { newValue in
                        if newValue == 3 {
                            isAddingNewPlant = true
                            selectedSideMenuTab = 0
                        }
                    }
                    if selectedSideMenuTab == 4 {
                        // Dimmed background to focus on the pop-up
                                Color.black.opacity(0.3)
                                    .ignoresSafeArea()
                                    .onTapGesture { selectedSideMenuTab = 0 } // Close if they tap outside

                        VStack(alignment: .leading, spacing: 15) {
                            Text("About Plant Mama")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.dotBrown)
                                .frame(maxWidth: .infinity, alignment: .center)

                            Text("Created by a plant mama, for plant mamas.")
                                .italic()
                                //.frame(maxWidth: .infinity)
                            Text("This app was built to help you track your plant’s growth and stay on top of daily care.")
                                .font(.footnote)

                            VStack(alignment: .leading, spacing: 10) {
                                Label("Your Data is Yours", systemImage: "lock.shield")
                                    .font(.subheadline).bold()
                                Text("No information is collected. Everything is stored on your device.")
                                    .font(.footnote)

                                Label("Photo Storage", systemImage: "photo.on.rectangle")
                                    .font(.subheadline).bold()
                                Text("Photos are stored in a 'Plant Mama' album. Even if the app is deleted, your photos stay in your library.")
                                    .font(.footnote)

                                Label("Important", systemImage: "exclamationmark.triangle")
                                    .font(.subheadline).bold()
                                Text("If you delete the app, your plant records are permanently lost, as we do not use cloud storage.")
                                    .font(.footnote)
                            }
                            
                            Button("Done") {
                                selectedSideMenuTab = 0
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.dotBrown)
                            .frame(maxWidth: .infinity)
                        }
                        .padding()

                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white)
                                )
                                .padding(40) // Space from screen edges
                                .transition(.scale.combined(with: .opacity))
                            }
                        //}
                        //.animation(.spring(), value: selectedSideMenuTab)
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
/*
#Preview(traits: .plantSampleData) {
    ContentView()
}

 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 NavigationView {
 ContentView().environmentObject(PlantData())
 
 }
 }
 }
 /**/*/
