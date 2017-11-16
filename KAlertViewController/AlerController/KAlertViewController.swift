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
    
    public var alertStyleEdging: CGFloat = 15
    
    public var alertViewOriginY: CGFloat = 0
    
    public var actionSheetStyleEdging: CGFloat = 0
    
    public var backgoundTapDismissEnable = false {
        didSet {
            tapGesture.isEnabled = backgoundTapDismissEnable
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
        addSingleTapGesture()
        configAlerView()
    }
    
    // MARK: - @action
    @objc func signleTap(gesture: UITapGestureRecognizer) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - @func
    
    // MARK: - @private properties
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(signleTap(gesture:)))
    
    private var alertViewCenterYConstraint: NSLayoutConstraint?
    private var alertViewCenterYOffset: CGFloat = 0
    // MARK: - @private func
    
    private func configController() {
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    private func addBackgroundView() {
        backgroundView.backgroundColor = self.backgroundColor
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundView, at: 0)
        view.addConstraintTo(view: backgroundView, edgeInsert: UIEdgeInsets.zero)
    }
    
    private func addSingleTapGesture() {
        view.isUserInteractionEnabled = true
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    private func configAlerView() {
        if let alertView = alertView {
            alertView.isUserInteractionEnabled = true
            view.addSubview(alertView)
            alertView.translatesAutoresizingMaskIntoConstraints = false
            
            switch preferredStyle! {
            case .alert:
                layoutAlertStyleView()
            case .actionSheet:
                layoutActionSheetStyleView()
            }
        }
    }
    
    private func configAlertViewWidth() {
        if alertView!.frame.size != CGSize.zero {
            alertView?.addConstraint(width: alertView!.frame.width, height: alertView!.frame.height)
        } else {
            var findAlertViewWidthConstraint = false
            for constraint in alertView!.constraints {
                if constraint.firstAttribute == .width {
                    findAlertViewWidthConstraint = true
                    break
                }
            }
            
            if !findAlertViewWidthConstraint {
                alertView?.addConstraint(width: view.frame.width - 2 * alertStyleEdging, height: 0)
            }
        }
    }
    
    private func layoutActionSheetStyleView() {
        // centerX
        view.addConstraintCenterXTo(alertView, centerYTo: nil)
        configAlertViewWidth()
        // centerY
        alertViewCenterYConstraint = view.addConstraintCenterYTo(alertView, constant: 0)
        
        if (alertViewOriginY > 0) {
            alertView?.layoutIfNeeded()
            alertViewCenterYOffset = alertViewOriginY - view.frame.height - alertView!.frame.height/2
            alertViewCenterYConstraint?.constant = alertViewCenterYOffset
        }else{
            alertViewCenterYOffset = 0
        }
    }
    
    private func layoutAlertStyleView() {
        // remove width constaint
        for constraint in alertView!.constraints {
            if constraint.firstAttribute == .width {
                alertView?.removeConstraint(constraint)
                break;
            }
        }
        
        // add edge constraint
        view.addConstraintWith(view: alertView!, topView: nil, leftView: view, bottomView: view, rightView: view, edgeInsert: UIEdgeInsetsMake(0, actionSheetStyleEdging, 0, -actionSheetStyleEdging))
        
        if alertView!.frame.height > 0 {
            // height
            alertView?.addConstraint(width: 0, height: alertView!.frame.height)
        }
    }
    
}

extension KAlertController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard transitionAnimation != nil else { return nil }
        
        switch transitionAnimation! {
        case .fade:
            return KAlertFadeAnimation(isPresent: true)
        case .scaleFade:
            return KAlertScaleFadeAnimation(isPresent: true)
        case .dropDown:
            return KAlertDropDownAnimation(isPresent: true)
        case .custom:
            return nil
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard transitionAnimation != nil else { return nil }
        
        switch transitionAnimation! {
        case .fade:
            return KAlertFadeAnimation(isPresent: false)
        case .scaleFade:
            return KAlertScaleFadeAnimation(isPresent: false)
        case .dropDown:
            return KAlertDropDownAnimation(isPresent: false)
        case .custom:
            return nil
        }
    }
}

extension UIView {
    
    func addConstraintTo(view: UIView, edgeInsert: UIEdgeInsets) {
        addConstraintWith(view: view, topView: self, leftView: self, bottomView: self, rightView: self, edgeInsert: edgeInsert)
    }
    
    func addConstraintCenterXTo(_ xView: UIView?, centerYTo yView: UIView?) {
        if let xView = xView {
            self.addConstraint(NSLayoutConstraint(item: xView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        }
        
        if let yView = yView {
            self.addConstraint(NSLayoutConstraint(item: yView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        }
    }
    
    func addConstraint(width: CGFloat, height: CGFloat) {
        if width > 0 {
            self.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width))
        }
        
        if height > 0 {
            self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height))
        }
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
    
    func addConstraintCenterYTo(_ yView: UIView?, constant: CGFloat) -> NSLayoutConstraint? {
        if let yView = yView {
            let centerYConstraint = NSLayoutConstraint(item: yView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: constant)
            self.addConstraint(centerYConstraint)
            return centerYConstraint
        }
        return nil
    }
}
