//
//  BaseAnimation.swift
//  transition
//
//  Created by 张坤 on 2017/11/15.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit

public protocol BaseAnimationProtocol: UIViewControllerAnimatedTransitioning {
    var isPresent: Bool { get set }
    init(isPresent: Bool)
    func presentAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning)
    func dismissAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning)
}

public class BaseAnimation: NSObject, BaseAnimationProtocol {
    
    static let transitionDuration: TimeInterval = 0.4
    
    public var isPresent: Bool
    
    required public init(isPresent: Bool) {
        self.isPresent = isPresent
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return BaseAnimation.transitionDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            presentAnimateTransition(transitionContext)
        } else {
            dismissAnimateTransition(transitionContext)
        }
    }
    
    public func presentAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    public func dismissAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
}

