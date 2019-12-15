//
//  FavoriteRecipe.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 01/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation
import CoreData

class FavoriteRecipe: NSManagedObject {
    
    static func saveRecipe(recipe: Recipe) {
        let favoriteRecipe = FavoriteRecipe(context: AppDelegate.viewContext)
        favoriteRecipe.name = recipe.label
        favoriteRecipe.image = recipe.image
        favoriteRecipe.ingredients = recipe.ingredientLines.joined(separator: "; ")
        favoriteRecipe.like = Double(recipe.yield)
        favoriteRecipe.time = Double(recipe.totalTime)
        favoriteRecipe.url = recipe.url
        try? AppDelegate.viewContext.save()
    }
    
    static func removeRecipe(recipe: Recipe) {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", "\(recipe.label)")
        
        do {
            let recipes = try AppDelegate.viewContext.fetch(request)
            for recipe in recipes {
                AppDelegate.viewContext.delete(recipe)
            }
            try? AppDelegate.viewContext.save()
        }
        catch
        {
            print(error)
        }
    }
    
    static func containsRecipe(recipe: Recipe) -> Bool {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS %@", "\(recipe.label)")
        
        guard let recipes = try? AppDelegate.viewContext.fetch(request), recipes.count > 0 else { return false }
        return true
    }
    
    static var all: [Recipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let favoriteRecipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        guard let recipes = favoriteRecipesToRecipes(favoriteRecipes: favoriteRecipes) else { return [] }
        return recipes
    }

    private static func favoriteRecipesToRecipes(favoriteRecipes: [FavoriteRecipe]) -> [Recipe]? {
        var recipes = [Recipe]()
        for favoriteRecipe in favoriteRecipes {
            guard let name = favoriteRecipe.name,
                let image = favoriteRecipe.image,
                let ingredients = favoriteRecipe.ingredients,
                let url = favoriteRecipe.url else {
                    return nil
            }
            recipes.append(Recipe(label: name,
                                  image: image,
                                  url: url, yield: Int(favoriteRecipe.like),
                                  ingredientLines: ingredients.components(separatedBy: "; "),
                                  totalTime: Int(favoriteRecipe.time)))
        }
        return recipes
    }
}
