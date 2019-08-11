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
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
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

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tweets[indexPath.row].twitterName
        return cell
    }
}
