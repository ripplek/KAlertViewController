# KAlertViewController

Swift简单的AlertView

![](https://img.shields.io/badge/releases-v0.0.2-green.svg) ![](https://img.shields.io/badge/pod-v0.0.2-brightgreen.svg) [![apm](https://img.shields.io/apm/l/vim-mode.svg)](https://github.com/ripplek/KKPhotoBrowser/blob/master/LICENSE) ![](https://img.shields.io/badge/platform-iOS-lightgrey.svg)

## Features
##### 功能浏览
![](https://github.com/ripplek/KAlertViewController/blob/master/GIF/Untitled.gif)

## Requirements
* iOS9.0+
* Xcode9.0+
* Swift4.0+

## Installation with CocoaPods
通过cocoaPods将KAlertViewController集成到你的项目中，首先要确保你已经安装了cocoaPods，然后执行
`$pod init`
配置`podfile`文件
```
target 'TargetName' do
pod 'KAlertViewController'
end
```
配置完成后执行
`$pod install`
## usage

```
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
```
