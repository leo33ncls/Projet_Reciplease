//
//  APIKeysService.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 28/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation

class APIKeysService {
    // Variable name of API Key in the plist file
    static let recipeAPIId = "recipeAPIId"
    static let recipeAPIKey = "recipeAPIKey"
    static let fileName = "Keys"

    // Function which returns the API Key from a plist file
    static func valueForAPIKey(named keyname: String, fileName: String, bundleClass: AnyClass) -> String? {
        guard let path = Bundle(for: bundleClass).path(forResource: fileName, ofType: "plist") else { return nil }
        let keys = NSDictionary(contentsOfFile: path)
        guard let value = keys?.object(forKey: keyname) as? String else { return nil }
        return value
    }
}
