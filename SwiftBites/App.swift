import SwiftUI
import SwiftData

@main
struct SwiftBitesApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Ingredient.self,
            RecipeIngredient.self,
            _Category.self,
            Recipe.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
  var body: some Scene {
    WindowGroup {
      ContentView()
//        .environment(\.storage, Storage())
    }
    .modelContainer(sharedModelContainer)
  }
}
