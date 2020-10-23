//
//  CoreDataHelper.swift
//  Reciplease
//
//  Created by mickael ruzel on 12/10/2020.
//

import Foundation
import CoreData
import SDWebImage

final class CoreDataManager {
    
    // MARK: - Properties
    
    private var context: NSManagedObjectContext
    
    var allRecipes: Recipes {
        let request: NSFetchRequest<StoredRecipe> = StoredRecipe.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "addedDate", ascending: false)
        ]
        
        guard let result = try? context.fetch(request) else {
            return []
        }
        
        var recipes: Recipes {
            var recipes = [Recipe]()
            result.forEach { (storedRecipe) in
                let newRecipe = Recipe(label: storedRecipe.name ?? "unknown", url: storedRecipe.url ?? "", image: "", dataImage: storedRecipe.image, yield: storedRecipe.yield, totalTime: storedRecipe.totalTime, ingredientLines: storedRecipe.ingredients ?? [], bookMarked: true)
                recipes.append(newRecipe)
            }
            
            return recipes
        }
        
        return recipes
    }
    
    var allRecipesAsStored: [StoredRecipe] {
        let request: NSFetchRequest<StoredRecipe> = StoredRecipe.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "addedDate", ascending: false)
        ]
        
        guard let result = try? context.fetch(request) else {
            return []
        }
        
        return result
    }
    
    // MARK: - Init
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    convenience init() {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        self.init(context: appDel.persistentContainer.viewContext)
    }
    
    // MARK: - Methodes
    
    func storeRecipe(_ recipe: Recipe, image: Data){
        let newRecipe = StoredRecipe(context: context)
        newRecipe.name = recipe.label
        newRecipe.ingredients = recipe.ingredientLines
        newRecipe.totalTime = recipe.totalTime
        newRecipe.yield = recipe.yield
        newRecipe.addedDate = Date()
        newRecipe.url = recipe.url
        newRecipe.image = image
        
        saveContext()
    }
    
    
    func deleteRecipe(_ recipe: Recipe) {
        guard let recipeToDelete = allRecipesAsStored.first(where: {$0.name == recipe.label}) else {
            return
        }
        context.delete(recipeToDelete)
        
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
