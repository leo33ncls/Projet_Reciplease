//
//  RecipeListService.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 26/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation
import Alamofire

class RecipeListService {
    private static let recipeBaseURL = "https://api.edamam.com/search"
    
    private func createRecipeURL(ingredients: [String]) -> URL? {
        var ingredientsList = ""
        for i in 0..<ingredients.count {
            ingredientsList += ingredients[i] + " "
        }
        var recipeURL = URLComponents(string: RecipeListService.recipeBaseURL)
        recipeURL?.queryItems = [URLQueryItem(name: "q", value: ingredientsList), URLQueryItem(name: "app_id", value: ""), URLQueryItem(name: "app_key", value: "")]
        
        guard let url = recipeURL?.url else { return nil }
        return url
    }
    
    func getRecipeList(ingredients: [String], callback: @escaping (Bool, RecipeList?) -> Void) {
        guard let url = createRecipeURL(ingredients: ingredients) else { return }
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else {
                callback(false, nil)
                return
            }
            
            guard let responseJSON = try? JSONDecoder().decode(RecipeList.self, from: data) else {
                callback(false, nil)
                return
            }
            
            callback(true, responseJSON)
        }
    }
    
    func getRecipeImage(image: String, completionHandler: @escaping (Data?) -> Void) {
        guard let imageURL = URL(string: image) else { return }
        Alamofire.request(imageURL).responseJSON { (response) in
            guard let imageData = response.data else {
                return
            }
            completionHandler(imageData)
        }
    }
    
}
