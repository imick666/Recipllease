//
//  RecipesModel.swift
//  Reciplease
//
//  Created by mickael ruzel on 05/10/2020.
//

import Foundation

struct RecipesModel: Decodable {
    var hits: [HitsModel]
    
    struct HitsModel: Decodable {
        var recipe: RecipeModel
        var bookmarked: Bool
        
        struct RecipeModel: Decodable {
            var image: String
            var totalTime: Double
            var ingredientLines: [String]
        }
    }
}
