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
    // The base URL of the recipe API
    private static let recipeBaseURL = "https://api.edamam.com/search"
    
    // Function which creates an Url with parameters
    private func createRecipeURL(ingredients: [String]) -> URL? {
        let appId = APIKeysService.recipeAPIId
        let appKey = APIKeysService.recipeAPIKey
        
        let stringIngredient = ingredients.joined(separator: " ")
        var recipeURL = URLComponents(string: RecipeListService.recipeBaseURL)
        recipeURL?.queryItems = [URLQueryItem(name: "q", value: stringIngredient),
                                 URLQueryItem(name: "app_id", value: APIKeysService.valueForAPIKey(named: appId)),
                                 URLQueryItem(name: "app_key", value: APIKeysService.valueForAPIKey(named: appKey))]
        
        guard let url = recipeURL?.url else { return nil }
        return url
    }
    
    // Function which gets an objet RecipeList from a response request
    func getRecipeList(ingredients: [String], callback: @escaping (Bool, RecipeList?) -> Void) {
        guard let url = createRecipeURL(ingredients: ingredients) else {
            callback(false, nil)
            return
        }
        
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
    
    // Function which gets an recipe image from a response request
    func getRecipeImage(image: String?, completionHandler: @escaping (Data?) -> Void) {
        guard let imageString = image else { return }
        guard let imageURL = URL(string: imageString) else { return }
        Alamofire.request(imageURL).responseJSON { (response) in
            guard let imageData = response.data else {
                return
            }
            completionHandler(imageData)
        }
    }
    
}
