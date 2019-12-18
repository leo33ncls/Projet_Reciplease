//
//  RecipeList.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 26/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation
import CoreData

// MARK: - RecipeList
struct RecipeList: Decodable {
    let q: String
    let from, to: Int
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int
}
