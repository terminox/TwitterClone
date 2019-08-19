//
//  MainViewController.swift
//  TwitterClone
//
//  Created by Yossa Bourne on 8/11/19.
//  Copyright © 2019 Yossa Bourne. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    var scrollViewController: ScrollViewController!
    var scrollView: UIScrollView!
    
    lazy var menuViewController: MenuViewController = {
        return MenuViewController()
    }()
    
    lazy var homeViewController: UINavigationController = {
        return UINavigationController(rootViewController: HomeViewController())
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        placeSubviews()
        addConstraints()
    }
}

private extension MainViewController {
    func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func placeSubviews() {
        addChild(scrollViewController)
        view.addSubview(scrollViewController.view)
        scrollViewController.didMove(toParent: self)
    }
    
    func setUpSubviews() {
        scrollViewController = {
            let svc = ScrollViewController()
            svc.delegate = self
            
            scrollView = svc.view as? UIScrollView
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            
            return svc
        }()
    }
}

// MARK: - ScrollViewControllerDelegate
extension MainViewController: ScrollViewControllerDelegate {
    var viewControllers: [UIViewController?] {
        return [menuViewController, homeViewController]
    }
    
    var initialViewController: UIViewController {
        return homeViewController
    }
    
    func scrollViewController(_ scrollViewController: ScrollViewController, widthScaleForScreenAt index: Int) -> CGFloat {
        switch index {
        case 0:
            return 0.8
        default:
            return 1.0
        }
    }
    
    func scrollViewDidScroll() {
        // MARK: - TODO
    }
}
