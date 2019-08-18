//
//  ScrollViewController.swift
//  TwitterClone
//
//  Created by Yossa Bourne on 8/17/19.
//  Copyright © 2019 Yossa Bourne. All rights reserved.
//

import UIKit

protocol ScrollViewControllerDelegate: AnyObject {
    var viewControllers: [UIViewController?] { get }
    var initialViewController: UIViewController { get }
    
    func scrollViewDidScroll()
}

class ScrollViewController: UIViewController {
    
    // MARK: - Properties
    var scrollView: UIScrollView {
        return view as! UIScrollView
    }
    
    var pageSize: CGSize {
        return scrollView.frame.size
    }
    
    var viewControllers: [UIViewController?]!
    weak var delegate: ScrollViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func loadView() {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        view = scrollView
        view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewControllers = delegate?.viewControllers
        
        for (index, vc) in viewControllers.enumerated() {
            if let vc = vc {
                addChild(vc)
                vc.view.frame = frame(for: index)
                scrollView.addSubview(vc.view)
                vc.didMove(toParent: self)
            }
        }
        
        scrollView.contentSize = CGSize(width: pageSize.width * CGFloat(viewControllers.count),
                                        height: pageSize.height)
        
        if let initialVC = delegate?.initialViewController {
            setViewController(to: initialVC, animated: false)
        }
    }
}

// MARK: - Public Methods
extension ScrollViewController {
    func setViewController(to viewController: UIViewController, animated: Bool) {
        guard let index = index(for: viewController) else {
            return
        }
        
        let contentOffset = CGPoint(x: pageSize.width * CGFloat(index),
                                    y: 0)
        let duration = animated ? 0.2 : 0.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.scrollView.setContentOffset(contentOffset, animated: animated)
        })
    }
}

// MARK: - Private Methods
private extension ScrollViewController {
    func index(for viewController: UIViewController?) -> Int? {
        return viewControllers.firstIndex(of: viewController)
    }
    
    func frame(for index: Int) -> CGRect {
        return CGRect(x: CGFloat(index) * pageSize.width,
                      y: 0,
                      width: pageSize.width,
                      height: pageSize.height)
    }
}

// MARK: - UIScrollViewDelegate
extension ScrollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll()
    }
}
