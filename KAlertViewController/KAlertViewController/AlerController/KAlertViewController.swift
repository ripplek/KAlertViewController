//
//  MineAlertController.swift
//  transition
//
//  Created by 张坤 on 2017/11/15.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit

enum AlertControllerStyle {
    case alert
    case actionSheet
}

enum TransitionAnimationType {
    case fade
    case scaleFade
    case dropDown
    case custom
}

class MineAlertController: UIViewController {
    
    // MARK: - @IBOutlet
    
    // MARK: - @properties
    public var alertView: UIView?
    public var preferredStyle: AlertControllerStyle?
    public var transitionAnimation: TransitionAnimationType?
    
    // MARK: - @override
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(alertView: UIView, preferredStyle: AlertControllerStyle, transitionAnimation: TransitionAnimationType) {
        self.init(nibName: nil, bundle: nil)
        self.alertView = alertView
        self.preferredStyle = preferredStyle
        self.transitionAnimation = transitionAnimation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - @func
    
    // MARK: - @private properties
    
    // MARK: - @private func
    
    private func configController() {
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
}

extension MineAlertController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard transitionAnimation != nil else { return nil }
        
        switch transitionAnimation! {
        case .fade:
            return nil
        case .scaleFade:
            return nil
        case .dropDown:
            return nil
        case .custom:
            return nil
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

