import SwiftUI
import SwiftData

struct CategoriesView: View {
    @Query private var categories: [_Category]
    @State private var query: String
    
    init(query: String = "") {
        self._query = State(initialValue: query)
        let predicate = #Predicate<_Category> { category in
            query.isEmpty || category.name.localizedStandardContains(query)
        }
        
        self._categories = Query(filter: predicate, sort: \_Category.name, animation: .bouncy)
    }

  // MARK: - Body

  var body: some View {
    NavigationStack {
      content
        .navigationTitle("Categories")
        .toolbar {
          if !categories.isEmpty {
            NavigationLink(value: CategoryForm.Mode.add) {
              Label("Add", systemImage: "plus")
            }
          }
        }
        .navigationDestination(for: CategoryForm.Mode.self) { mode in
          CategoryForm(mode: mode)
        }
        .navigationDestination(for: RecipeForm.Mode.self) { mode in
          RecipeForm(mode: mode)
        }
    }
  }

  // MARK: - Views

//  @ViewBuilder
//  private var content: some View {
//    if categories.isEmpty {
//      empty
//    } else {
//      list(for: categories.filter {
//        if query.isEmpty {
//          return true
//        } else {
//          return $0.name.localizedStandardContains(query)
//        }
//      })
//    }
//  }
    
  @ViewBuilder
  private var content: some View {
    if categories.isEmpty {
      empty
    } else {
      list(for: categories)
    }
  }

  private var empty: some View {
    ContentUnavailableView(
      label: {
        Label("No Categories", systemImage: "list.clipboard")
      },
      description: {
        Text("Categories you add will appear here.")
      },
      actions: {
        NavigationLink("Add Category", value: CategoryForm.Mode.add)
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

  private func list(for categories: [_Category]) -> some View {
    ScrollView(.vertical) {
      if categories.isEmpty {
        noResults
      } else {
        LazyVStack(spacing: 10) {
          ForEach(categories, content: CategorySection.init)
        }
      }
    }
//    .searchable(text: $query)
  }
}


#Preview {
    CategoriesView()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Empty") {
    CategoriesView()
        .modelContainer(for: _Category.self, inMemory: true)
}

#Preview("filtered") {
    CategoriesView(query: "it")
        .modelContainer(SampleData.shared.modelContainer)
}
