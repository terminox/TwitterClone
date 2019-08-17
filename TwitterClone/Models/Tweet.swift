//
//  Tweet.swift
//  TwitterClone
//
//  Created by Yossa Bourne on 8/11/19.
//  Copyright © 2019 Yossa Bourne. All rights reserved.
//

import Foundation

struct Tweet: Codable {
    var id: Int
    var twitterName: String
    var twitterId: String
    var isVerified: Bool
    var hasThread: Bool
    var date: String
    var body: String
    var commentsCount: Int
    var retweetsCount: Int
    var likesCount: Int
}
