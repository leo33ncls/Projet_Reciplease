//
//  APIKeysService.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 28/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation

class APIKeysService {
    static let recipeAPIId = "recipeAPIId"
    static let recipeAPIKey = "recipeAPIKey"
    
    static func valueForAPIKey(named keyname: String) -> String? {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            let keys = NSDictionary(contentsOfFile: path)
            guard let value = keys?.object(forKey: keyname) as? String else { return nil }
            return value
        } else {
            return nil
        }
    }
}
