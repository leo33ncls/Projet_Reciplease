//
//  RecipeListServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Léo NICOLAS on 02/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import XCTest
import Mockingjay
@testable import Reciplease

class RecipeListServiceTestCase: XCTestCase {

    func testGetRecipeListShouldPostFailedCallbackIfIncorrectData() {
        // Given
        stub(everything, jsonData(FakeResponseData.incorrectData))
        let recipeListService = RecipeListService()

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeListService.getRecipeList(ingredients: ["Lemon"]) { (success, recipeList) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipeList)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetRecipeListShouldPostFailedCallbackIfNoData() {
        // Given
        stub(everything, FakeResponseData.notFoundStub)
        let recipeListService = RecipeListService()

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeListService.getRecipeList(ingredients: ["Lemon"]) { (success, recipeList) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipeList)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetRecipeShouldPostSuccesCallbackIfNoErrorAndCorrectData() {
        // Given
        stub(everything, jsonData(FakeResponseData.recipeListCorrectData))
        let recipeListService = RecipeListService()

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeListService.getRecipeList(ingredients: ["Lemon"]) { (success, recipeList) in
            //Then
            let count = 165091
            let firstRecipeName = "Lemon Sorbet"
            let firstRecipeUrl = "http://www.bbcgoodfood.com/recipes/4583/"
            let secondRecipeName = "Lemon Sparkler"
            let secondRecipeLike = 2

            XCTAssertTrue(success)
            XCTAssertNotNil(recipeList)

            XCTAssertEqual(recipeList?.count, count)
            XCTAssertEqual(recipeList?.hits[0].recipe.label, firstRecipeName)
            XCTAssertEqual(recipeList?.hits[0].recipe.url, firstRecipeUrl)
            XCTAssertEqual(recipeList?.hits[1].recipe.label, secondRecipeName)
            XCTAssertEqual(recipeList?.hits[1].recipe.yield, secondRecipeLike)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testGetRecipeImageShouldReturnNilCompletionHandlerIfNoImageUrl() {
        // Given
        let recipeListService = RecipeListService()

        // When
        //let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeListService.getRecipeImage(image: nil) { (data) in
            // Then
            XCTAssertNil(data)
        }
        //wait(for: [expectation], timeout: 0.1)
    }

    func testGetRecipeImageShouldReturnDataIfImageData() {
    // Given
    stub(everything, jsonData(FakeResponseData.imageData))
    let recipeListService = RecipeListService()

    // When
    //let expectation = XCTestExpectation(description: "Wait for queue change.")
    recipeListService.getRecipeImage(image: "https://www.edamam.com/web-img/78e/78ef0e463d0aadbf2caf7b6237cd5f12.jpg") { (data) in
        // Then
        XCTAssertNotNil(data)
    }
    //wait(for: [expectation], timeout: 0.1)
    }
    
}
