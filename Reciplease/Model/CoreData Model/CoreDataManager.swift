//
//  CoreDataHelper.swift
//  Reciplease
//
//  Created by mickael ruzel on 12/10/2020.
//

import Foundation
import CoreData

final class CoreDataManager {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = AppDelegate().persistentContainer.viewContext) {
        self.context = context
    }
    
    var allRecipes: [StoredRecipe] {
        let request: NSFetchRequest<StoredRecipe> = StoredRecipe.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "addedDate", ascending: true)
        ]
        
        guard let result = try? context.fetch(request) else {
            return []
        }
        return result
    }
    
    func storeRecipe(_ recipe: Recipe) {
        let newRecipe = StoredRecipe(context: context)
        newRecipe.name = recipe.label
        newRecipe.ingredients = recipe.ingredientLines
        newRecipe.totalTime = recipe.totalTime
        newRecipe.yield = recipe.yield
        newRecipe.addedDate = Date()
        newRecipe.url = recipe.url
        
        saveContext()
    }
    
    func deleteRecipe(_ recipe: StoredRecipe) {
        context.delete(recipe)
        
        saveContext()
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            return
        }
    }
    
}
