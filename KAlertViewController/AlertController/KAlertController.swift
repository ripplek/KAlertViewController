//
//  MineAlertController.swift
//  transition
//
//  Created by 张坤 on 2017/11/15.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit

public enum AlertControllerStyle {
    case alert
    case actionSheet
}

public enum TransitionAnimationType {
    case fade
    case scaleFade
    case dropDown
    case bounceUp
    case custom
}

public class KAlertController: UIViewController {
    
    // MARK: - @IBOutlet
    
    // MARK: - @properties
    public var alertView: UIView?
    public var preferredStyle: AlertControllerStyle?
    public var transitionAnimation: TransitionAnimationType?
    public var transitionAnimationClass: BaseAnimationProtocol.Type?
    
    public var backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
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
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience public init(alertView: UIView, preferredStyle: AlertControllerStyle = .alert, transitionAnimation: TransitionAnimationType = .fade, transitionAnimationClass: BaseAnimationProtocol.Type? = nil) {
        
        self.init(nibName: nil, bundle: nil)
        self.alertView = alertView
        self.preferredStyle = preferredStyle
        self.transitionAnimation = transitionAnimation
        self.transitionAnimationClass = transitionAnimationClass
    }
    
    deinit {
        if preferredStyle! == .alert {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        addBackgroundView()
        addSingleTapGesture()
        configAlerView()
        view.layoutIfNeeded()
        if preferredStyle! == .alert {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    // MARK: - @action
    @objc func signleTap(gesture: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
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
    
    private func layoutAlertStyleView() {
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
    
    private func layoutActionSheetStyleView() {
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
    
    // MARK: - @Notification
    // 处理键盘遮挡问题
    @objc func keyboardWillShow(notification: Notification) {
        let keyboardRect = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        let alertViewBottomEdge = (view.frame.height - alertView!.frame.height) / 2 - alertViewCenterYOffset
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let differ = keyboardRect.height - alertViewBottomEdge
        
        if alertViewCenterYConstraint!.constant == -differ - statusBarHeight {
            return
        }
        
        if differ >= 0 {
            alertViewCenterYConstraint?.constant = alertViewCenterYOffset - differ - statusBarHeight
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        alertViewCenterYConstraint?.constant = alertViewCenterYOffset
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension KAlertController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard transitionAnimation != nil else { return nil }
        
        switch transitionAnimation! {
        case .fade:
            return KAlertFadeAnimation(isPresent: true)
        case .scaleFade:
            return KAlertScaleFadeAnimation(isPresent: true)
        case .dropDown:
            return KAlertDropDownAnimation(isPresent: true)
        case .bounceUp:
            return KAlertBounceUpAnimation(isPresent: true)
        case .custom:
            return transitionAnimationClass?.init(isPresent: true) ?? nil
        }
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard transitionAnimation != nil else { return nil }
        
        switch transitionAnimation! {
        case .fade:
            return KAlertFadeAnimation(isPresent: false)
        case .scaleFade:
            return KAlertScaleFadeAnimation(isPresent: false)
        case .dropDown:
            return KAlertDropDownAnimation(isPresent: false)
        case .bounceUp:
            return KAlertBounceUpAnimation(isPresent: false)
        case .custom:
            return transitionAnimationClass?.init(isPresent: false) ?? nil
        }
    }
}


