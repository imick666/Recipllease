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
            var label: String
            var image: String
            var yield: Double
            var totalTime: Double
            var ingredientLines: [String]
        }
    }
}
