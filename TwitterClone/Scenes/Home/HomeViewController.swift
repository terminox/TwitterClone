//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Yossa Bourne on 8/11/19.
//  Copyright © 2019 Yossa Bourne. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var tableView: UITableView!
    private var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .rgb(0xE7ECF2)
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TweetCell.self, forCellReuseIdentifier: TweetCell.reuseIdentifier)
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loadTweets { (tweets) in
            self.tweets = tweets
            tableView.reloadData()
        }
    }
}

extension HomeViewController {
    private func loadTweets(completion: ([Tweet]) -> Void) {
        var tweets: [Tweet] = []
        
        defer {
            completion(tweets)
        }
        
        guard let path = Bundle.main.path(forResource: "tweets", ofType: "json") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        if let data = try? Data(contentsOf: url),
            let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let dict = response as? [String: Any],
                let tweetsObject = dict["data"],
                let tweetsData = try? JSONSerialization.data(withJSONObject: tweetsObject, options: .fragmentsAllowed) {
                tweets = (try? decoder.decode([Tweet].self, from: tweetsData)) ?? []
            }
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetCell.reuseIdentifier, for: indexPath) as? TweetCell else {
            fatalError()
        }
        
        let tweet = tweets[indexPath.row]
        cell.configure(using: TweetCellPresenter.present(tweet: tweet))
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
