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

    @IBAction func showAlertAction(_ sender: Any) {
        let alertView = KAlertView(title: "KAlertView", message: "Warmly celebrate the completion of KAlertView creation")
        alertView.add(action: KalertAction(title: "取消", style: .cancel, handler: { (action) in
            print(action.title)
        }))
        
         //MARK: - 注意循环引用
        alertView.add(action: KalertAction(title: "确定", style: .destructive, handler: { [unowned alertView] (action) in
            print(action.title)
            for textField in alertView.textFields {
                print(textField.text ?? "")
            }
        }))
        alertView.addTextField { (textField) in
            textField.placeholder = "请输入账号"
        }
        alertView.addTextField { (textField) in
            textField.placeholder = "请输入密码"
        }
        let alertVC = KAlertController(alertView: alertView, preferredStyle: .alert)
        alertVC.backgoundTapDismissEnable = true
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func showActionSheetAction(_ sender: Any) {
        let alertView = KAlertView(title: "KAlertView", message: "Warmly celebrate the completion of KAlertView creation")
        alertView.add(action: KalertAction(title: "默认1", style: .default, handler: { (action) in
            print(action.title)
        }))
        alertView.add(action: KalertAction(title: "默认2", style: .default, handler: { (action) in
            print(action.title)
        }))
        alertView.add(action: KalertAction(title: "默认3", style: .default, handler: { (action) in
            print(action.title)
        }))
        alertView.add(action: KalertAction(title: "删除", style: .destructive, handler: { (action) in
            print(action.title)
        }))
        alertView.add(action: KalertAction(title: "取消", style: .cancel, handler: { (action) in
            print(action.title)
        }))
        let alertVC = KAlertController(alertView: alertView, preferredStyle: .actionSheet)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func dropDownAction(_ sender: Any) {
        let alertView = KAlertView(title: "KAlertView", message: "Warmly celebrate the completion of KAlertView creation")
        alertView.add(action: KalertAction(title: "取消", style: .cancel, handler: { (action) in
            print(action.title)
        }))
        let alertVC = KAlertController(alertView: alertView, preferredStyle: .alert, transitionAnimation: .dropDown)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func showAlert(_ sender: Any) {
        let shareView = UINib(nibName: "ShareView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ShareView
        let alertVC = KAlertController(alertView: shareView, preferredStyle: .alert, transitionAnimation: .bounceUp, transitionAnimationClass: nil)
        shareView.dismissClosure = {
            alertVC.dismiss(animated: true, completion: nil)
        }
        
        self.present(alertVC, animated: true, completion: nil)
    }
    @IBOutlet weak var show: UIButton!
    
}

