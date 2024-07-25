//
//  SwiftDataModels.swift
//  SwiftBites
//
//  Created by Madhu Babu Adiki on 7/24/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class Ingredient {
        
    let id: UUID
    
    @Attribute(.unique)
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
    
    static let sampleData = [
        Ingredient(name: "Pizza Dough"),
        Ingredient(name: "Tomato Sauce"),
        Ingredient(name: "Mozzarella Cheese"),
        Ingredient(name: "Fresh Basil Leaves"),
        Ingredient(name: "Extra Virgin Olive Oil"),
        Ingredient(name: "Salt"),
        Ingredient(name: "Chickpeas"),
        Ingredient(name: "Tahini"),
        Ingredient(name: "Lemon Juice"),
        Ingredient(name: "Garlic"),
        Ingredient(name: "Cumin"),
        Ingredient(name: "Water"),
        Ingredient(name: "Paprika"),
        Ingredient(name: "Parsley"),
        Ingredient(name: "Spaghetti"),
        Ingredient(name: "Eggs"),
        Ingredient(name: "Parmesan Cheese"),
        Ingredient(name: "Pancetta"),
        Ingredient(name: "Black Pepper"),
        Ingredient(name: "Dried Chickpeas"),
        Ingredient(name: "Onions"),
        Ingredient(name: "Cilantro"),
        Ingredient(name: "Coriander"),
        Ingredient(name: "Baking Powder"),
        Ingredient(name: "Chicken Thighs"),
        Ingredient(name: "Yogurt"),
        Ingredient(name: "Cardamom"),
        Ingredient(name: "Cinnamon"),
        Ingredient(name: "Turmeric")
    ]
}


@Model
final class RecipeIngredient {
    
    let id: UUID
    var ingredient: Ingredient
    var quantity: String
    
    init(id: UUID = UUID(), ingredient: Ingredient, quantity: String = "") {
        self.id = id
        self.ingredient = ingredient
        self.quantity = quantity
    }
}

@Model
final class Recipe {
    let id: UUID
    @Attribute(.unique)
    var name: String
    var summary: String
    var category: _Category?
    var serving: Int
    var time: Int
    var ingredients: [RecipeIngredient]
    var instructions: String
    var imageData: Data?
    
    init(id: UUID = UUID(),
         name: String = "",
         summary: String = "",
         category: _Category? = nil,
         serving: Int = 1,
         time: Int = 5,
         ingredients: [RecipeIngredient] = [],
         instructions: String = "",
         imageData: Data? = nil) {
        
        self.id = id
        self.name = name
        self.summary = summary
        self.category = category
        self.serving = serving
        self.time = time
        self.ingredients = ingredients
        self.instructions = instructions
        self.imageData = imageData
    }
    
    static let sampleData = [
        
        Recipe(
          name: "Classic Margherita Pizza",
          summary: "A simple yet delicious pizza with tomato, mozzarella, basil, and olive oil.",
          category: nil,
          serving: 4,
          time: 50,
          ingredients: [],
          instructions: "Preheat oven, roll out dough, apply sauce, add cheese and basil, bake for 20 minutes.",
          imageData: UIImage(named: "margherita")?.pngData()
        ),
        Recipe(
            name: "Classic Falafel",
            summary: "A traditional Middle Eastern dish of spiced, fried chickpea balls, often served in pita bread.",
            category: nil,
            serving: 4,
            time: 60,
            ingredients: [],
            instructions: "Soak chickpeas overnight. Blend with onions, garlic, herbs, and spices. Form into balls, add baking powder, and fry until golden.",
            imageData: UIImage(named: "falafel")?.pngData()
        )
    ]
}

@Model
final class _Category {
    
    let id: UUID
    @Attribute(.unique)
    var name: String
    var recipes: [Recipe]
    
    init(id: UUID = UUID(), name: String = "", recipes: [Recipe] = []) {
        self.id = id
        self.name = name
        self.recipes = recipes
    }
    
    static let sampleData = [
        _Category(name: "Italian"),
        _Category(name: "Middle Eastern")
    ]
}
