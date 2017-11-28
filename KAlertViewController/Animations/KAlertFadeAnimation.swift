//
//  KAlertFadeAnimation.swift
//  KAlertViewController
//
//  Created by 奥卡姆 on 2017/11/16.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit

public class KAlertFadeAnimation: BaseAnimation {

    override public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    
        if self.isPresent {
            return 0.45
        }
        return 0.25
    }
    
    override public func presentAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        let alertController = transitionContext.viewController(forKey:
            UITransitionContextViewControllerKey.to) as! KAlertController
        
        alertController.backgroundView.alpha = 0.0
        switch alertController.preferredStyle! {
        case .alert:
            alertController.alertView?.alpha = 0.0
            alertController.alertView?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
        case .actionSheet:
            alertController.alertView?.transform = CGAffineTransform(translationX: 0, y: (alertController.alertView?.frame.height)!)
        }
    
        let containerView = transitionContext.containerView
        containerView.addSubview(alertController.view)
        
        UIView.animate(withDuration: 0.25, animations: {
            alertController.backgroundView.alpha = 1.0
            switch alertController.preferredStyle! {
            case .alert:
                alertController.alertView?.alpha = 1.0
                alertController.alertView?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                
            case .actionSheet:
                alertController.alertView?.transform = CGAffineTransform(translationX: 0, y: -10.0)
            }
            
        }) { (finished : Bool) in
            
            UIView.animate(withDuration: 0.2, animations: {
                alertController.alertView?.transform = CGAffineTransform.identity
            }, completion: { (finished :  Bool) in
                transitionContext.completeTransition(true)
            })
        }
    }
    
    override public func dismissAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        let alertController = transitionContext.viewController(forKey:
            UITransitionContextViewControllerKey.from) as! KAlertController
        
        UIView.animate(withDuration: 0.25, animations: {
            alertController.backgroundView.alpha = 0.0
            
            switch alertController.preferredStyle! {
            case .alert:
                alertController.alertView?.alpha = 0.0
                alertController.alertView?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                
            case .actionSheet:
                alertController.alertView?.transform = CGAffineTransform(translationX: 0, y: (alertController.alertView?.frame.height)!)
            }
        }) { (finished : Bool) in
            transitionContext.completeTransition(true)
        }
    }
}


class KAlertScaleFadeAnimation: BaseAnimation {
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    override func presentAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        let alertController = transitionContext.viewController(forKey:
            UITransitionContextViewControllerKey.to) as! KAlertController
        alertController.backgroundView.alpha = 0.0
        
        switch alertController.preferredStyle! {
        case .alert:
            alertController.alertView?.alpha = 0.0
            alertController.alertView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        case .actionSheet:
            alertController.alertView?.transform = CGAffineTransform(translationX: 0, y: (alertController.alertView?.frame.height)!)
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(alertController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            alertController.backgroundView.alpha = 1.0
            
            switch alertController.preferredStyle! {
            case .alert:
                alertController.alertView?.alpha = 1.0
                alertController.alertView?.transform = CGAffineTransform.identity
                
            case .actionSheet:
                alertController.alertView?.transform = CGAffineTransform.identity
            }
        }) { (finished : Bool) in
            transitionContext.completeTransition(true)
        }
    }

    
    override func dismissAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        let alertController = transitionContext.viewController(forKey:
            UITransitionContextViewControllerKey.from) as! KAlertController
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            alertController.backgroundView.alpha = 0.0
            
            switch alertController.preferredStyle! {
            case .alert:
                alertController.alertView?.alpha = 0.0
                alertController.alertView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                
            case .actionSheet:
                alertController.alertView?.transform = CGAffineTransform(translationX: 0, y: (alertController.alertView?.frame.height)!)
            }
            
        }) { (finished : Bool) in
            transitionContext.completeTransition(true)
        }
    }
}


class KAlertDropDownAnimation: BaseAnimation {
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        if self.isPresent {
            return 0.5
        }
        return 0.25
    }
    
    override func presentAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        let alertController = transitionContext.viewController(forKey:
            UITransitionContextViewControllerKey.to) as! KAlertController
        alertController.backgroundView.alpha = 0.0
        
        switch alertController.preferredStyle! {
        case .alert:
            alertController.alertView?.transform = CGAffineTransform(translationX: 0, y: -(alertController.alertView?.frame.maxY)!)
            
        case .actionSheet:
            print("don't support ActionSheet style")
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(alertController.view)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.65,
                       initialSpringVelocity: 0.5,
                       options: UIViewAnimationOptions(rawValue: 0),
                       animations: {
            
            alertController.backgroundView.alpha = 1.0
            alertController.alertView?.transform = CGAffineTransform.identity
            
        }) { (finished : Bool) in
            transitionContext.completeTransition(true)
        }
        
    }
    
    
    override func dismissAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        let alertController = transitionContext.viewController(forKey:
            UITransitionContextViewControllerKey.from) as! KAlertController
        
        
        UIView.animate(withDuration: 0.25, animations: {
            alertController.backgroundView.alpha = 0.0
            
            switch alertController.preferredStyle! {
            case .alert:
                alertController.alertView?.alpha = 0.0
                alertController.alertView?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                
            case .actionSheet:
                print("don't support ActionSheet style")
            }
        }) { (finished : Bool) in
            transitionContext.completeTransition(true)
        }
    }
}

class KAlertBounceUpAnimation: BaseAnimation {
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        if self.isPresent {
            return 0.5
        }
        return 0.25
    }
    
    override func presentAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        let alertController = transitionContext.viewController(forKey:
            UITransitionContextViewControllerKey.to) as! KAlertController
        alertController.backgroundView.alpha = 0.0
        
        switch alertController.preferredStyle! {
        case .alert:
            alertController.alertView?.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            
        case .actionSheet:
            print("don't support ActionSheet style")
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(alertController.view)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.65,
                       initialSpringVelocity: 0.5,
                       options: UIViewAnimationOptions(rawValue: 0),
                       animations: {
                        
                        alertController.backgroundView.alpha = 1.0
                        alertController.alertView?.transform = CGAffineTransform.identity
                        
        }) { (finished : Bool) in
            transitionContext.completeTransition(true)
        }
        
    }
    
    
    override func dismissAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        let alertController = transitionContext.viewController(forKey:
            UITransitionContextViewControllerKey.from) as! KAlertController
        
        
        UIView.animate(withDuration: 0.25, animations: {
            alertController.backgroundView.alpha = 0.0
            
            switch alertController.preferredStyle! {
            case .alert:
                alertController.alertView?.alpha = 0.0
                alertController.alertView?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                
            case .actionSheet:
                print("don't support ActionSheet style")
            }
        }) { (finished : Bool) in
            transitionContext.completeTransition(true)
        }
    }
}






















