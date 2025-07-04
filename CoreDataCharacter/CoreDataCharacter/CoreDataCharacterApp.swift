import SwiftUI

@main
struct CoreDataCharacterApp: App {
    @StateObject private var storeCoordinator = CoreDataManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, storeCoordinator.container.viewContext)
        }
    }
}
