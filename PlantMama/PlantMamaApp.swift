import SwiftUI
import SwiftData

// Keeping your typealiases intact to start fresh on Schema 1
typealias Plant = PlantSchemaV1.Plant
typealias Photo = PlantSchemaV1.Photo
typealias Note = PlantSchemaV1.Note
typealias Reminder = PlantSchemaV1.Reminder

@main
struct PlantMamaApp: App {
    let container: ModelContainer
    
    init() {
        // 1. Manually force-create the missing directory to bypass the iOS simulator bug
        let fileManager = FileManager.default
        if let libraryDirectory = fileManager.urls(for: .libraryDirectory, in: .userDomainMask).first {
            let appSupportURL = libraryDirectory.appendingPathComponent("Application Support", isDirectory: true)
            
            if !fileManager.fileExists(atPath: appSupportURL.path) {
                try? fileManager.createDirectory(at: appSupportURL, withIntermediateDirectories: true, attributes: nil)
                print("Successfully pre-created Application Support directory to bypass sandbox error.")
            }
        }
        
        // 2. Initialize the container safely inside the lifecycle step
        do {
            let schema = Schema([
                Plant.self,
                Photo.self,
                Reminder.self,
                Note.self
            ])
            let configuration = ModelConfiguration(schema: schema)
            container = try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Could not initialize fresh SwiftData container: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .modelContainer(container) // Injects your container down to the views
        }
    }
}
