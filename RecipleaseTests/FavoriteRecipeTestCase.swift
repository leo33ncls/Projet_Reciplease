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

class RecipeListServiceTestCase: XCTestCase {
    
    func test() {
        let favoriteRecipe = FavoriteRecipe(context: AppDelegate.viewContext)
        favoriteRecipe.name = "Lemon Risotto"
        favoriteRecipe.image = "https://www.edamam.com/web-img/3a9/3a91b23c3e102678c5b72ce0b6e006de.jpg"
        favoriteRecipe.url = "http://smittenkitchen.com/2007/06/catch-up-solstice-edition/"
        try? AppDelegate.viewContext.save()
        
        XCTAssertEqual(FavoriteRecipe.all.count, 1)
        XCTAssertEqual(FavoriteRecipe.all[0].name, "Lemon Risotto")
    }
}
