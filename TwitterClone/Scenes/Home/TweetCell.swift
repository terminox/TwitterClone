//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Yossa Bourne on 8/11/19.
//  Copyright © 2019 Yossa Bourne. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    class var reuseIdentifier: String { return "\(self)" }
    
    // MARK: - Views
    private var profileImageView: UIImageView!
    private var nameLabel: UILabel!
    private var verifiedIcon: UIImageView!
    private var idLabel: UILabel!
    private var dateLabel: UILabel!
    private var bodyLabel: UILabel!
    private var bodyImageView: UIImageView!
    private var commentIconView: UIImageView!
    private var commentsCountLabel: UILabel!
    private var retweetIconView: UIImageView!
    private var retweetsCountLabel: UILabel!
    private var likeIconView: UIImageView!
    private var likesCountLabel: UILabel!
    private var shareIconView: UIImageView!
    
    // MARK: - Stack Views & Containers
    private var nameContainer: UIView!
    private var contentStackView: UIStackView!
    
    // MARK: - Constants
    private var bottomSpaceConstraint: NSLayoutConstraint!
    private let profileImageHeight: CGFloat = 48.0
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
        placeSubviews()
        activateConstraints()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
    }
    
    // MARK: - Configuration
    func configure(using presenter: TweetCellPresentable) {
        profileImageView.image = UIImage(named: presenter.profileImageName)
        nameLabel.text = presenter.name
        verifiedIcon.isHidden = !presenter.isVerified
        idLabel.text = presenter.id
        dateLabel.text = presenter.date
        bodyLabel.text = presenter.body
        
        if let bodyImage = UIImage(named: presenter.bodyImageName) {
            bodyImageView.image = bodyImage
        } else {
            bodyImageView.isHidden = true
            bottomSpaceConstraint.isActive = false
        }
    }
}

extension TweetCell {
    private func activateConstraints() {
        nameLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(.init(752), for: .horizontal)

        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageHeight),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16),
            nameLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: nameContainer.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: nameContainer.bottomAnchor),
            idLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            idLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: nameContainer.trailingAnchor, constant: -8),
            dateLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            nameContainer.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nameContainer.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            nameContainer.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            bodyLabel.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bodyImageView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 8),
            bodyImageView.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor),
            bodyImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bodyImageView.heightAnchor.constraint(equalTo: bodyImageView.widthAnchor, multiplier: 0.56)
        ])
        
        bottomSpaceConstraint = subviews.last!.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16)
        var secondaryBottomSpaceConstraint: NSLayoutConstraint?
        
        if subviews.count >= 2 {
            let n = subviews.count - 2
            secondaryBottomSpaceConstraint = subviews[n].bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16)
            secondaryBottomSpaceConstraint?.priority = .init(999)
        }
        
        bottomSpaceConstraint.isActive = true
        secondaryBottomSpaceConstraint?.isActive = true
    }
    
    private func placeSubviews() {
        addSubview(profileImageView)
        addSubview(nameContainer)
        addSubview(bodyLabel)
        addSubview(bodyImageView)
        
        let nameContainerSubviews: [UIView] = [nameLabel, verifiedIcon, idLabel, dateLabel]
        nameContainerSubviews.forEach { nameContainer.addSubview($0) }
    }
    
    private func setUpSubviews() {
        profileImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.backgroundColor = .gray
            return imageView
        }()
        
        nameLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        verifiedIcon = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        idLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        dateLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        bodyLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        
        bodyImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 16
            imageView.backgroundColor = .gray
            return imageView
        }()
        
        commentIconView = {
            UIImageView()
        }()
        
        commentsCountLabel = {
            UILabel()
        }()
        
        retweetsCountLabel = {
            UILabel()
        }()
        
        likeIconView = {
            UIImageView()
        }()
        
        likesCountLabel = {
            UILabel()
        }()
        
        shareIconView = {
            UIImageView()
        }()
        
        nameContainer = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    }
}
