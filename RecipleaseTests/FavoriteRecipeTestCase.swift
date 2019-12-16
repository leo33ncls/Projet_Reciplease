//
//  FavoriteRecipeTestCase.swift
//  RecipleaseTests
//
//  Created by Léo NICOLAS on 10/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class FavoriteRecipeTestCase: XCTestCase {

    override func setUp() {
        super.setUp()
        insertRecipeData()
    }
    
    func insertRecipeData() {
        func insertFavoriteRecipe(name: String, image: String, ingredients: String, like: Double, time: Double, url: String) {
            let favoriteRecipe = FavoriteRecipe(context: AppDelegate.viewContext)
            favoriteRecipe.name = name
            favoriteRecipe.image = image
            favoriteRecipe.ingredients = ingredients
            favoriteRecipe.like = like
            favoriteRecipe.time = time
            favoriteRecipe.url = url
        }
        
        insertFavoriteRecipe(name: "Lemon Risotto",
                             image: "https://www.edamam.com/web-img/3a9/3a91b23c3e102678c5b72ce0b6e006de.jpg",
                             ingredients: "Lemon; Sugar",
                             like: 12,
                             time: 25,
                             url: "http://smittenkitchen.com/2007/06/catch-up-solstice-edition/")
        try? AppDelegate.viewContext.save()
        
        insertFavoriteRecipe(name: "Apple crunch",
                             image: "https://apple-fakeimage.jpg",
                             ingredients: "Apple; biscuits",
                             like: 15,
                             time: 0,
                             url: "https://fakerecipe.com/")
        try? AppDelegate.viewContext.save()
    }
    
    func testAllShouldReturnThe2RecipesLemonRisottoAndAppleCrunch() {
        let recipes = FavoriteRecipe.all
        
        XCTAssertEqual(recipes.count, 2)
        XCTAssertEqual(recipes[0].label, "Lemon Risotto")
        XCTAssertEqual(recipes[1].label, "Apple crunch")
    }
    
    func testGivenARecipe_WhenSaveRecipeIsCalledOnTheRecipe_ThenTheRecipeShouldBeSaveOnTheDatabaseWithHisInfos() {
        let recipe = Recipe(label: "Pasta Carbonara",
                            image: "https://pasta-image.jpg",
                            url: "https://pasta-carbonara.com/",
                            yield: 12,
                            ingredientLines: ["Pasta", "Gibs", "Fresh Cream"],
                            totalTime: 20)
        
        FavoriteRecipe.saveRecipe(recipe: recipe)

        XCTAssertEqual(FavoriteRecipe.all.count, 3)
        XCTAssertEqual(FavoriteRecipe.all[2].label, recipe.label )
        XCTAssertEqual(FavoriteRecipe.all[2].image, recipe.image)
        XCTAssertEqual(FavoriteRecipe.all[2].ingredientLines, recipe.ingredientLines)
        XCTAssertEqual(FavoriteRecipe.all[2].url, recipe.url)
        XCTAssertEqual(FavoriteRecipe.all[2].yield, recipe.yield)
        XCTAssertEqual(FavoriteRecipe.all[2].totalTime, recipe.totalTime)
    }
    
    func testGivenARecipeContainedInTheDatabase_WhenRemoveRecipeIsCalled_ThenTheRecipeShouldBeRemoved() {
        let recipe = Recipe(label: "Apple crunch",
                            image: "https://apple-fakeimage.jpg",
                            url: "https://fakerecipe.com/",
                            yield: 15,
                            ingredientLines: ["Apple", "biscuits"],
                            totalTime: 0)
        
        FavoriteRecipe.removeRecipe(recipe: recipe)
        
        XCTAssertEqual(FavoriteRecipe.all.count, 1)
    }

    func testGivenARecipeNoContainedInTheDatabase_WhenRemoveRecipeIsCalled_ThenNothingShouldBeRemoved() {
        let recipe = Recipe(label: "Tomato Soup",
                            image: "https://",
                            url: "https://",
                            yield: 0,
                            ingredientLines: [],
                            totalTime: 0)
        
        FavoriteRecipe.removeRecipe(recipe: recipe)
        
        XCTAssertEqual(FavoriteRecipe.all.count, 2)
    }
    
    func testGivenARecipeContainedInTheDatabase_WhenContainsRecipeIsCalled_ThenReturnShouldBeTrue() {
        let recipe = Recipe(label: "Apple crunch",
                            image: "https://apple-fakeimage.jpg",
                            url: "https://fakerecipe.com/",
                            yield: 15,
                            ingredientLines: ["Apple", "biscuits"],
                            totalTime: 0)
        
        let isContained = FavoriteRecipe.containsRecipe(recipe: recipe)
        
        XCTAssertTrue(isContained)
    }
    
    func testGivenARecipeNoContainedInTheDatabase_WhenContainsRecipeIsCalled_ThenReturnShouldBeFalse() {
        let recipe = Recipe(label: "Tomato Soup",
                            image: "https://",
                            url: "https://",
                            yield: 0,
                            ingredientLines: [],
                            totalTime: 0)
        
        let isContained = FavoriteRecipe.containsRecipe(recipe: recipe)
        
        XCTAssertFalse(isContained)
    }
    
    override func tearDown() {
        super.tearDown()
        flushData()
    }
    
    func flushData() {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
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
}
