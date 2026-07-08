import SwiftUI
import FirebaseCore
import SwiftData

// Keeping your typealiases intact to start fresh on Schema 1
typealias Plant = PlantSchemaV1.Plant
typealias Photo = PlantSchemaV1.Photo
typealias Note = PlantSchemaV1.Note
typealias Reminder = PlantSchemaV1.Reminder

@main
struct PlantMamaApp: App {
    let container: ModelContainer
    
    @StateObject private var syncManager: FirestoreSyncManager
    @StateObject private var authManager = AuthManager()
    
    init() {
        // 1. Manually force-create the missing directory to bypass the iOS simulator bug
        let fileManager = FileManager.default
        if let libraryDirectory = fileManager.urls(for: .libraryDirectory, in: .userDomainMask).first {
            let appSupportURL = libraryDirectory.appendingPathComponent("Application Support", isDirectory: true)
            
            if !fileManager.fileExists(atPath: appSupportURL.path) {
                try? fileManager.createDirectory(at: appSupportURL, withIntermediateDirectories: true, attributes: nil)
                print("Successfully pre-created Application Support directory to bypass sandbox error.")
            }
            FirebaseApp.configure()
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
            let initializedContainer = try ModelContainer(for: schema, configurations: [configuration])
            self.container = initializedContainer
            
            let context = initializedContainer.mainContext
            self._syncManager = StateObject(wrappedValue: FirestoreSyncManager(context: context))
            
        } catch {
            fatalError("Could not initialize fresh SwiftData container: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if !authManager.isInitialCheckComplete {
                    ProgressView()
                } else if authManager.currentUser != nil {
                    // User is authenticated successfully
                    NavigationView {
                        ContentView()
                    }
                } else {
                    // No authenticated session found
                    AuthenticationView()
                        .environmentObject(authManager)
                }
            }
            .modelContainer(container)
            .environmentObject(syncManager) 
        }
    }
}
