//
//  ShareView.swift
//  KAlertViewController
//
//  Created by 张坤 on 2017/11/17.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit

class ShareView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var dismissClosure: (()->())?
    
    @IBAction func dismiss() {
        dismissClosure?()
    }

}
