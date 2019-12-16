//
//  APIKeysServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Léo NICOLAS on 16/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import XCTest
@testable import Reciplease

class APIKeysServiceTestCase: XCTestCase {
    
    func testGivenCorrectKeyAndFileName_WhenValueForAPIKeyIsCalled_ThenApiKeyShouldBeEqualToTest123() {
        let keyName = "testKey"
        let fileName = "KeysTest"
        
        let apiKey = APIKeysService.valueForAPIKey(named: keyName, fileName: fileName,
                                                   bundleClass: APIKeysServiceTestCase.self)
        
        XCTAssertEqual(apiKey, "test123")
    }
    
    func testGivenIncorrectKeyName_WhenValueForAPIKeyIsCalled_ThenApiKeyShouldBeNil() {
        let incorrectKeyName = "incorrectKey"
        let fileName = "KeysTest"
        
        let apiKey = APIKeysService.valueForAPIKey(named: incorrectKeyName, fileName: fileName,
                                                   bundleClass: APIKeysServiceTestCase.self)
        
        XCTAssertNil(apiKey)
    }
    
    func testGivenIncorrectFileName_WhenValueForAPIKeyIsCalled_ThenApiKeyShouldBeNil() {
        let keyName = "testKey"
        let incorrectFileName = "incorrectKeysTest"
        
        let apiKey = APIKeysService.valueForAPIKey(named: keyName, fileName: incorrectFileName,
                                                   bundleClass: APIKeysServiceTestCase.self)
        
        XCTAssertNil(apiKey)
    }
}
