#
#  Be sure to run `pod spec lint KAlertViewController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|



    s.name         = "KAlertViewController"
    s.version      = "1.0.0"
    s.summary      = "A alert library for iOS"
    s.description  = <<-EOS
    KAlertViewController is a custom alert view.
    It is applicable to the daily development of common frame requirements.

    Instructions for installation
    are in [the README](https://github.com/ripplek/KAlertViewController).
    EOS
    s.homepage     = "https://github.com/ripplek/KAlertViewController"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "张坤" => "ripple_k@163.com" }
    s.source       = { :git => "https://github.com/ripplek/KAlertViewController.git", :tag => "#{s.version}" }
    s.ios.deployment_target = "8.0"
    s.source_files  = "KAlertViewController/AlertController/*.swift", "KAlertViewController/AlertView/*.swift", "KAlertViewController/Animations/*.swift"
    s.framework = 'UIKit'
    s.requires_arc = true

end
