//
//  SampleData.swift
//  SwiftBites
//
//  Created by Madhu Babu Adiki on 7/24/24.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        return modelContainer.mainContext
    }
    
    private init() {
        let schema = Schema([
            Ingredient.self,
            RecipeIngredient.self,
            _Category.self,
            Recipe.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            insertSampleData()
        } catch {
            fatalError("Couldn't create model container: \(error)")
        }
    }
    
    func insertSampleData() {
        for ingredient in Ingredient.sampleData {
            context.insert(ingredient)
        }
        
        for recipe in Recipe.sampleData {
            context.insert(recipe)
        }
        
        for category in _Category.sampleData {
            context.insert(category)
        }
        
        Recipe.sampleData[0].category = _Category.sampleData[0]
        Recipe.sampleData[1].category = _Category.sampleData[1]
        
        Recipe.sampleData[0].ingredients.append(RecipeIngredient(ingredient: Ingredient.sampleData[0], quantity: "1 ball"))
        Recipe.sampleData[1].ingredients.append(RecipeIngredient(ingredient: Ingredient.sampleData[1], quantity: "1 spoon"))
        
        
        do {
            try context.save()
        } catch {
            print("Sample data context failed to save")
        }
    }
    
    var ingredient: Ingredient {
        Ingredient.sampleData[0]
    }
    
    var recipe: Recipe {
        Recipe.sampleData[0]
    }
    
    var category: _Category {
        _Category.sampleData[0]
    }
    
}
