//
//  TweetCellPresenter.swift
//  TwitterClone
//
//  Created by Yossa Bourne on 8/16/19.
//  Copyright © 2019 Yossa Bourne. All rights reserved.
//

import UIKit

protocol TweetCellPresentable {
    var name: String { get }
    var id: String { get }
    var isVerified: Bool { get }
    var hasThread: Bool { get }
    var date: String { get }
    var body: String { get }
    var commentsCount: Int { get }
    var retweetsCount: Int { get }
    var likesCount: Int { get }
    var profileImageName: String { get }
    var bodyImageName: String { get }
}

struct TweetCellPresenter {
    private struct Presenter: TweetCellPresentable {
        var name: String
        var id: String
        var isVerified: Bool
        var hasThread: Bool
        var date: String
        var body: String
        var commentsCount: Int
        var retweetsCount: Int
        var likesCount: Int
        var profileImageName: String
        var bodyImageName: String
    }
    
    static func present(tweet: Tweet) -> TweetCellPresentable {
        let id = "@\(tweet.twitterId)"
        let date = "· \(tweet.date)"
        let profileImageName = "profile-\(tweet.id)"
        let bodyImageName = "image-\(tweet.id)"
        return Presenter(name: tweet.twitterName,
                         id: id,
                         isVerified: tweet.isVerified,
                         hasThread: tweet.hasThread,
                         date: date,
                         body: tweet.body,
                         commentsCount: tweet.commentsCount,
                         retweetsCount: tweet.retweetsCount,
                         likesCount: tweet.likesCount,
                         profileImageName: profileImageName,
                         bodyImageName: bodyImageName)
    }
}
