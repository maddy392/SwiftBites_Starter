import SwiftUI

struct IngredientForm: View {
    enum Mode: Hashable {
    case add
    case edit(Ingredient)
    }

    var mode: Mode
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    private let title: String
    @State private var error: Error?
    @FocusState private var isNameFocused: Bool


    init(mode: Mode) {
    self.mode = mode
    switch mode {
    case .add:
      _name = .init(initialValue: "")
      title = "Add Ingredient"
    case .edit(let ingredient):
      _name = .init(initialValue: ingredient.name)
      title = "Edit \(ingredient.name)"
    }
    }

//    @Environment(\.storage) private var storage
//    @Environment(\.dismiss) private var dismiss

  // MARK: - Body

  var body: some View {
    Form {
      Section {
        TextField("Name", text: $name)
          .focused($isNameFocused)
      }
      if case .edit(let ingredient) = mode {
        Button(
          role: .destructive,
          action: {
            delete(ingredient: ingredient)
          },
          label: {
            Text("Delete Ingredient")
              .frame(maxWidth: .infinity, alignment: .center)
          }
        )
      }
    }
    .onAppear {
      isNameFocused = true
    }
    .onSubmit {
      save()
    }
    .navigationTitle(title)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("Save", action: save)
          .disabled(name.isEmpty)
      }
    }
  }

  // MARK: - Data

  private func delete(ingredient: Ingredient) {
      context.delete(ingredient)
      do {
          try context.save()
          dismiss()
      } catch {
          self.error = error
      }
  }

  private func save() {
    do {
      switch mode {
      case .add:
          let newIngredient = Ingredient(name: name)
          context.insert(newIngredient)
//        try storage.addIngredient(name: name)
      case .edit(let ingredient):
          ingredient.name = name
      }
        try context.save()
        dismiss()
    } catch {
      self.error = error
    }
  }
}

#Preview("Add") {
    NavigationStack {
        IngredientForm(mode: .add)
    }
}

#Preview("Edit") {
    NavigationStack {
        IngredientForm(mode: .edit(SampleData.shared.ingredient))
    }
}
