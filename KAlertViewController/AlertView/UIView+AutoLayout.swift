//
//  UIView+AutoLayout.swift
//  KAlertViewController
//
//  Created by 张坤 on 2017/11/21.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit

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
    
    func addConstraintEqual(view: UIView, widthView: UIView?, heightView: UIView?) {
        if let widthView = widthView {
            addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: widthView, attribute: .width, multiplier: 1, constant: 0))
        }
        
        if let heightView = heightView {
            addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: heightView, attribute: .height, multiplier: 1, constant: 0))
        }
    }
    
    @discardableResult
    func addConstraint(topView: UIView, bottomView: UIView, constant: CGFloat) -> NSLayoutConstraint {
        
        let topBottomConstraint = NSLayoutConstraint(item: topView, attribute: .bottom, relatedBy: .equal, toItem: bottomView, attribute: .top, multiplier: 1, constant: -constant)
        self.addConstraint(topBottomConstraint)
        return topBottomConstraint
    }
    
    func addConstraint(leftView: UIView, rightView: UIView, constant: CGFloat) {
        
        self.addConstraint(NSLayoutConstraint(item: leftView, attribute: .right, relatedBy: .equal, toItem: rightView, attribute: .left, multiplier: 1, constant: -constant))
    }
    
    func removeConstraint(view: UIView, attribute: NSLayoutConstraint.Attribute) {
        for constant in self.constraints {
            
            if constant.firstAttribute == attribute && constant.firstItem as! UIView == view {
                removeConstraint(constant)
                break
            }
        }
    }
}
