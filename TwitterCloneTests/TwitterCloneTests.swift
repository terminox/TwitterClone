//
//  TwitterCloneTests.swift
//  TwitterCloneTests
//
//  Created by Yossa Bourne on 8/11/19.
//  Copyright © 2019 Yossa Bourne. All rights reserved.
//

import XCTest
@testable import TwitterClone

class TwitterCloneTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_loadTweetsFromFile() {
        var tweets: [Tweet]?
        
        if let path = Bundle.main.path(forResource: "tweets", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let data = try Data(contentsOf: url)
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                if let response = response as? [String: Any], let tweetsObject = response["data"] {
                    let tweetsData = try JSONSerialization.data(withJSONObject: tweetsObject, options: .fragmentsAllowed)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    tweets = try decoder.decode([Tweet].self, from: tweetsData)
                }
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        
        XCTAssertEqual(tweets?.count, 5)
    }
}
