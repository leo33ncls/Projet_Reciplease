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

    // Function which saves a recipe as a FavoriteRecipe in the CoreData database
    static func saveRecipe(recipe: Recipe) {
        let favoriteRecipe = FavoriteRecipe(context: AppDelegate.viewContext)
        favoriteRecipe.uri = recipe.uri
        favoriteRecipe.name = recipe.label
        favoriteRecipe.image = recipe.image
        favoriteRecipe.ingredients = recipe.ingredientLines.joined(separator: "; ")
        favoriteRecipe.like = Double(recipe.yield)
        favoriteRecipe.time = Double(recipe.totalTime)
        favoriteRecipe.url = recipe.url
        try? AppDelegate.viewContext.save()
    }

    // Function which removes a recipe from the database based on the recipe name
    static func removeRecipe(recipe: Recipe) {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "uri == %@", "\(recipe.uri)")

        do {
            let recipes = try AppDelegate.viewContext.fetch(request)
            for recipe in recipes {
                AppDelegate.viewContext.delete(recipe)
            }
            try? AppDelegate.viewContext.save()
        } catch {
            print(error)
        }
    }

    // Function which says if a recipe is in the database based on the recipe name
    static func containsRecipe(recipe: Recipe) -> Bool {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "uri CONTAINS %@", "\(recipe.uri)")

        guard let recipes = try? AppDelegate.viewContext.fetch(request), recipes.count > 0 else { return false }
        return true
    }

    // Variable which returns all the recipes in the database
    static var all: [Recipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let favoriteRecipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        guard let recipes = favoriteRecipesToRecipes(favoriteRecipes: favoriteRecipes) else { return [] }
        return recipes
    }

    // Private func which convert an array of Favorite objet to an array of Recipe objet
    private static func favoriteRecipesToRecipes(favoriteRecipes: [FavoriteRecipe]) -> [Recipe]? {
        var recipes = [Recipe]()
        for favoriteRecipe in favoriteRecipes {
            guard let uri = favoriteRecipe.uri,
                let name = favoriteRecipe.name,
                let image = favoriteRecipe.image,
                let ingredients = favoriteRecipe.ingredients,
                let url = favoriteRecipe.url else {
                    return nil
            }
            recipes.append(Recipe(uri: uri,
                                  label: name,
                                  image: image,
                                  url: url,
                                  yield: Int(favoriteRecipe.like),
                                  ingredientLines: ingredients.components(separatedBy: "; "),
                                  totalTime: Int(favoriteRecipe.time)))
        }
        return recipes
    }
}
