import SwiftUI
import SwiftData

/// The main view that appears when the app is launched.
struct ContentView: View {
//  @Environment(\.storage) private var storage

  var body: some View {
    TabView {
      FilteredRecipesView()
        .tabItem {
          Label("Recipes", systemImage: "frying.pan")
        }

      FilteredCategoriesView()
        .tabItem {
          Label("Categories", systemImage: "tag")
        }

        FilteredIngredientsView()
        .tabItem {
          Label("Ingredients", systemImage: "carrot")
        }
    }
//    .onAppear {
//      storage.load()
//    }
  }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
