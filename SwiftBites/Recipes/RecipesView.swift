import SwiftUI
import SwiftData

struct RecipesView: View {
    @Environment(\.modelContext) private var context
    @Query private var recipes: [Recipe]
    @State private var query = ""
    @State private var sortOrder: SortOrder = .name
    
    init(query: String = "") {
        self._query = State(initialValue: query)
        let predicate = #Predicate<Recipe> { recipe in
            query.isEmpty || recipe.name.localizedStandardContains(query) || recipe.instructions.localizedStandardContains(query)
        }
                
        self._recipes = Query(filter: predicate)
    }
    
    enum SortOrder: String, CaseIterable, Identifiable {
        case name
        case servingLowToHigh
        case servingHighToLow
        case timeShortToLong
        case timeLongToShort
        
        var id: String {rawValue}
        
        var sortDescriptors: [SortDescriptor<Recipe>] {
            switch self {
            case .name:
                return [SortDescriptor(\Recipe.name)]
            case .servingLowToHigh:
                return [SortDescriptor(\Recipe.serving, order: .forward)]
            case .servingHighToLow:
                return [SortDescriptor(\Recipe.serving, order: .reverse)]
            case .timeShortToLong:
                return [SortDescriptor(\Recipe.time, order: .forward)]
            case .timeLongToShort:
                return [SortDescriptor(\Recipe.time, order: .reverse)]
            }
        }
    }

  // MARK: - Body

  var body: some View {
    NavigationStack {
      content
        .navigationTitle("Recipes")
        .toolbar {
          if !recipes.isEmpty {
            sortOptions
            ToolbarItem(placement: .topBarTrailing) {
              NavigationLink(value: RecipeForm.Mode.add) {
                  
                Label("Add", systemImage: "plus")
              }
            }
          }
        }
        .navigationDestination(for: RecipeForm.Mode.self) { mode in
          RecipeForm(mode: mode)
        }
    }
  }

  // MARK: - Views

  @ToolbarContentBuilder
  var sortOptions: some ToolbarContent {
    ToolbarItem(placement: .topBarLeading) {
      Menu("Sort", systemImage: "arrow.up.arrow.down") {
        Picker("Sort", selection: $sortOrder) {
          Text("Name")
                .tag(SortOrder.name)

          Text("Serving (low to high)")
                .tag(SortOrder.servingLowToHigh)

          Text("Serving (high to low)")
            .tag(SortOrder.servingHighToLow)

          Text("Time (short to long)")
            .tag(SortOrder.timeShortToLong)

          Text("Time (long to short)")
            .tag(SortOrder.timeLongToShort)
        }
      }
      .pickerStyle(.inline)
    }
  }

  @ViewBuilder
  private var content: some View {
    if recipes.isEmpty {
      empty
    } else {
      list(for: recipes)
    }
  }

  var empty: some View {
    ContentUnavailableView(
      label: {
        Label("No Recipes", systemImage: "list.clipboard")
      },
      description: {
        Text("Recipes you add will appear here.")
      },
      actions: {
        NavigationLink("Add Recipe", value: RecipeForm.Mode.add)
          .buttonBorderShape(.roundedRectangle)
          .buttonStyle(.borderedProminent)
      }
    )
  }

  private var noResults: some View {
    ContentUnavailableView(
      label: {
        Text("Couldn't find \"\(query)\"")
      }
    )
  }

  private func list(for recipes: [Recipe]) -> some View {
    ScrollView(.vertical) {
      if recipes.isEmpty {
        noResults
      } else {
        LazyVStack(spacing: 10) {
          ForEach(recipes, content: RecipeCell.init)
        }
      }
    }
//    .searchable(text: $query)
  }
}

#Preview {
    RecipesView()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Empty") {
    RecipesView()
        .modelContainer(for: Recipe.self, inMemory: true)
}

#Preview("filtered") {
    RecipesView(query: "marg")
        .modelContainer(SampleData.shared.modelContainer)
}
