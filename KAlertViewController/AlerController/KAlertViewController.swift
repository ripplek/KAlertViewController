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

class KAlertController: UIViewController {
    
    // MARK: - @IBOutlet
    
    // MARK: - @properties
    public var alertView: UIView?
    public var preferredStyle: AlertControllerStyle?
    public var transitionAnimation: TransitionAnimationType?
    public var transitionAnimationClass: UIViewControllerAnimatedTransitioning?
    
    public var backgroundColor = UIColor.white
    public var backgroundView = UIView() {
        didSet {
            if oldValue != backgroundView {
                
            }
        }
    }
    
    // MARK: - @override
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configController()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(alertView: UIView, preferredStyle: AlertControllerStyle = .alert, transitionAnimation: TransitionAnimationType = .fade, transitionAnimationClass: UIViewControllerAnimatedTransitioning? = nil) {
        
        self.init(nibName: nil, bundle: nil)
        self.alertView = alertView
        self.preferredStyle = preferredStyle
        self.transitionAnimation = transitionAnimation
        self.transitionAnimationClass = transitionAnimationClass
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        addBackgroundView()
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
    
    private func addBackgroundView() {
        
    }
}

extension KAlertController: UIViewControllerTransitioningDelegate {
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

extension UIView {
    
    func addConstraintTo(view: UIView, edgeInsert: UIEdgeInsets) {
        addConstraintWith(view: view, topView: self, leftView: self, bottomView: self, rightView: self, edgeInsert: edgeInsert)
    }
    
    func addConstraintWith(view: UIView, topView: UIView?, leftView: UIView?, bottomView: UIView?, rightView: UIView?, edgeInsert: UIEdgeInsets) {
        
        if let topView = topView {
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .top, multiplier: 1, constant: edgeInsert.top))
        }
        
        if let leftView = leftView {
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: leftView, attribute: .left, multiplier: 1, constant: edgeInsert.left))
        }
        
        if let bottomView = bottomView {
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: bottomView, attribute: .bottom, multiplier: 1, constant: edgeInsert.bottom))
        }
        
        if let rightView = rightView {
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: rightView, attribute: .right, multiplier: 1, constant: edgeInsert.right))
        }
    }
}
