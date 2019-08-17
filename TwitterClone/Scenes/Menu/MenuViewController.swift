//
//  MenuViewController.swift
//  TwitterClone
//
//  Created by Yossa Bourne on 8/17/19.
//  Copyright © 2019 Yossa Bourne. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - Views
    private var profileImageView: UIImageView!
    private var nameLabel: UILabel!
    private var idLabel: UILabel!
    private var followingsLabel: UILabel!
    private var followersLabel: UILabel!
    private var tableView: UITableView!
    
    // MARK: - Stack Views & Containers
    private var headerContainer: UIView!
    private var nameStackView: UIStackView!
    private var followingStackView: UIStackView!
    
    // MARK: - Constants
    private let profileImageHeight: CGFloat = 48.0
    private let menus: [String] = [
        "Profile",
        "Lists",
        "Bookmarks",
        "Moments"
    ]
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpSubviews()
        placeSubviews()
        addConstraints()
        
        nameLabel.text = "Yossa"
        idLabel.text = "@yossabourne"
        
        let followersString = NSMutableAttributedString()
        followersString.append(NSAttributedString(string: "32 ", attributes: nil))
        followersString.append(NSAttributedString(string: "Followers", attributes: nil))
        followersLabel.attributedText = followersString
        
        let followingsString = NSMutableAttributedString()
        followingsString.append(NSAttributedString(string: "8 ", attributes: nil))
        followingsString.append(NSAttributedString(string: "Followings", attributes: nil))
        followingsLabel.attributedText = followingsString
    }
}

// MARK - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = menus[indexPath.row]
        return cell
    }
}

extension MenuViewController {
    private func addConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16),
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageHeight),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            nameStackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            nameStackView.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            followingStackView.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            followingStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 16),
            headerContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerContainer.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let headerContainerBottomSpaceConstraint = headerContainer.subviews.last!.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: -16)
        headerContainerBottomSpaceConstraint.isActive = true
    }
    
    private func placeSubviews() {
        view.addSubview(headerContainer)
        view.addSubview(tableView)
        
        let headerSubviews: [UIView] = [profileImageView, nameStackView, followingStackView]
        headerSubviews.forEach { headerContainer.addSubview($0) }
    }
    
    private func setUpSubviews() {
        profileImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = .black
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = profileImageHeight / 2
            return imageView
        }()
        
        nameLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        idLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        followingsLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        followersLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        headerContainer = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        nameStackView = {
            let stackView = UIStackView(arrangedSubviews: [nameLabel, idLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .leading
            stackView.spacing = 4
            return stackView
        }()
        
        followingStackView = {
            let stackView = UIStackView(arrangedSubviews: [followingsLabel, followersLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.alignment = .lastBaseline
            stackView.spacing = 16
            return stackView
        }()
        
        tableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.separatorInset = .zero
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            return tableView
        }()
    }
}
