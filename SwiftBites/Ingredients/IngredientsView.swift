import SwiftUI
import SwiftData

struct IngredientsView: View {
    typealias Selection = (Ingredient) -> Void

    let selection: Selection?
    @State private var titleFilter : String
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var ingredients: [Ingredient]
    
    init(selection: Selection? = nil, titleFilter: String = "") {
        self.selection = selection
        self._titleFilter = State(initialValue: titleFilter)
        
        let predicate = #Predicate<Ingredient> {
            ingredient in titleFilter.isEmpty || ingredient.name.localizedStandardContains(titleFilter)
        }
        
        self._ingredients = Query(filter: predicate, sort: \Ingredient.name)
    }

  // MARK: - Body

  var body: some View {
    NavigationStack {
      content
        .navigationTitle("Ingredients")
        .toolbar {
          if !ingredients.isEmpty {
            NavigationLink(value: IngredientForm.Mode.add) {
              Label("Add", systemImage: "plus")
            }
          }
        }
        .navigationDestination(for: IngredientForm.Mode.self) { mode in
          IngredientForm(mode: mode)
        }
    }
  }

  // MARK: - Views

  @ViewBuilder
  private var content: some View {
    if ingredients.isEmpty {
      empty
    } else {
      list(for: ingredients)
    }
  }

  private var empty: some View {
    ContentUnavailableView(
      label: {
        Label("No Ingredients", systemImage: "list.clipboard")
      },
      description: {
        Text("Ingredients you add will appear here.")
      },
      actions: {
        NavigationLink("Add Ingredient", value: IngredientForm.Mode.add)
          .buttonBorderShape(.roundedRectangle)
          .buttonStyle(.borderedProminent)
      }
    )
  }

  private var noResults: some View {
    ContentUnavailableView(
      label: {
        Text("Couldn't find \"\(titleFilter)\"")
      }
    )
    .listRowSeparator(.hidden)
  }

  private func list(for ingredients: [Ingredient]) -> some View {
    List {
      if ingredients.isEmpty {
        noResults
      } else {
        ForEach(ingredients) { ingredient in
          row(for: ingredient)
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
              Button("Delete", systemImage: "trash", role: .destructive) {
                delete(ingredient: ingredient)
              }
            }
        }
      }
    }
//    .searchable(text: $titleFilter)
    .listStyle(.plain)
  }

  @ViewBuilder
  private func row(for ingredient: Ingredient) -> some View {
    if let selection {
      Button(
        action: {
          selection(ingredient)
          dismiss()
        },
        label: {
          title(for: ingredient)
        }
      )
    } else {
      NavigationLink(value: IngredientForm.Mode.edit(ingredient)) {
        title(for: ingredient)
      }
    }
  }

  private func title(for ingredient: Ingredient) -> some View {
    Text(ingredient.name)
      .font(.title3)
  }

  // MARK: - Data

  private func delete(ingredient: Ingredient) {
    modelContext.delete(ingredient)
      try? modelContext.save()
  }
}

#Preview("Sample") {
    IngredientsView()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Empty") {
    IngredientsView()
        .modelContainer(for: Ingredient.self, inMemory: true)
}

#Preview("filtered") {
    IngredientsView(titleFilter: "ba")
        .modelContainer(SampleData.shared.modelContainer)
}
