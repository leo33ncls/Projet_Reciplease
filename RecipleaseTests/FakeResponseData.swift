//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Léo NICOLAS on 16/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//
// swiftlint:disable force_try

import Foundation
import Mockingjay

class FakeResponseData {
    // Variable which simulates a correct data response for the RecipeListService
    static var recipeListCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "RecipeList", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    // Variable which simulates an image data
    static let imageData = "image".data(using: .utf8)!

    // Variable which simulates an incorrect data
    private static let data = """
    {
        "q": "Lemon"
    }
    """
    static let incorrectData = FakeResponseData.data.data(using: .utf8)!

    // Variable which simulates an NSError
    static let error = NSError(domain: "", code: 1, userInfo: nil)
}
