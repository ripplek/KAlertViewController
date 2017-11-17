//
//  ViewController.swift
//  KAlertViewController
//
//  Created by 张坤 on 2017/11/16.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(_ sender: Any) {
        let shareView = UINib(nibName: "ShareView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ShareView
        let alertVC = KAlertController(alertView: shareView, preferredStyle: .alert, transitionAnimation: .scaleFade, transitionAnimationClass: nil)
        shareView.dismissClosure = {
            alertVC.dismiss(animated: true, completion: nil)
        }
        
        self.present(alertVC, animated: true, completion: nil)
    }
    @IBOutlet weak var show: UIButton!
    
}

