//
//  KAlertView.swift
//  KAlertViewController
//
//  Created by 张坤 on 2017/11/21.
//  Copyright © 2017年 searainbow. All rights reserved.
//

import UIKit

struct KAlertViewDefault {
    static let width: CGFloat = 280
    
    static let contentViewEdge: CGFloat = 15
    static let contentViewspace: CGFloat = 15
    
    static let textLabelSpace: CGFloat = 6
    
    static let titleFont = UIFont(name: "HelveticaNeue-Bold", size: 18)
    static let titleColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    static let messageFont = UIFont(name: "HelveticaNeue", size: 15)
    static let messageColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    
    static let buttonTagOffset = 1000
    static let buttonSpace: CGFloat = 6
    static let buttonHeight: CGFloat = 44
    static let buttonCornerRadius: CGFloat = 4.0
    static let buttonFont = UIFont(name: "HelveticaNeue", size: 18)
    static let buttonDefaultBgColor = UIColor(red: 52/255.0, green: 152/255.0, blue: 219/255.0, alpha: 1)
    static let buttonCancelBgColor = UIColor(red: 127/255.0, green: 140/255.0, blue: 141/255.0, alpha: 1)
    static let buttonDestructiveBgColor = UIColor(red: 231/255.0, green: 76/255.0, blue: 60/255.0, alpha: 1)
    
    static let textFieldOffset = 1000
    static let textFieldHeight: CGFloat = 29
    static let textFieldEdge: CGFloat = 8
    static let textFieldBorderWidth: CGFloat = 0.5
    static let textFieldBorderColor = UIColor(red: 203/255.0, green: 203/255.0, blue: 203/255.0, alpha: 1)
    static let textFieldBgColor = UIColor.white
    static let textFieldFont = UIFont.systemFont(ofSize: 14)
}

public enum KAlertActionStyle {
    case `default`
    case cancel
    case destructive
}

public struct KAlertAction {
    let title: String
    let style: KAlertActionStyle
    let handler: ((KAlertAction)->())?
    
    public init(title: String, style: KAlertActionStyle, handler: ((KAlertAction)->())?) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}

public class KAlertView: UIView {
    
//MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configProperties()
        addContentViews()
        addTextLabels()
    }
    
    convenience public init(title: String, message: String) {
        self.init(frame: CGRect.zero)
        titleLabel.text = title
        messageLabel.text = message
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(NSStringFromClass(self.classForCoder),"--deinit")
    }
    
//MARK: - publicProperties
    public let titleLabel: UILabel = UILabel()
    public let messageLabel: UILabel = UILabel()
    
    public var alertViewWidth = KAlertViewDefault.width
    public var contentViewSpace = KAlertViewDefault.contentViewspace
    
    public var textLabelSpace = KAlertViewDefault.textLabelSpace
    public var textLabelContentViewEdge = KAlertViewDefault.contentViewEdge
    
    public var titleFont = KAlertViewDefault.titleFont {
        didSet {
            titleLabel.font = titleFont
        }
    }
    public var titleColor = KAlertViewDefault.titleColor {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    public var messageFont = KAlertViewDefault.messageFont {
        didSet {
            messageLabel.font = messageFont
        }
    }
    public var messageColor = KAlertViewDefault.messageColor {
        didSet {
            messageLabel.textColor = messageColor
        }
    }
    
    public var buttonHeight = KAlertViewDefault.buttonHeight
    public var buttonSpace = KAlertViewDefault.buttonSpace
    public var buttonContentViewEdge = KAlertViewDefault.contentViewEdge
    public var buttonContentViewTop = KAlertViewDefault.contentViewspace
    public var buttonCornerRadius = KAlertViewDefault.buttonCornerRadius
    public var buttonFont = KAlertViewDefault.buttonFont
    public var buttonDefaultBgColor = KAlertViewDefault.buttonDefaultBgColor
    public var buttonCancelBgColor = KAlertViewDefault.buttonCancelBgColor
    public var buttonDestructiveBgColor = KAlertViewDefault.buttonDestructiveBgColor
    
    public var textFieldHeight = KAlertViewDefault.textFieldHeight
    public var textFieldEdge = KAlertViewDefault.textFieldEdge
    public var textFieldBorderWidth = KAlertViewDefault.textFieldBorderWidth
    public var textFieldContentViewEdge = KAlertViewDefault.contentViewEdge
    public var textFieldBorderColor = KAlertViewDefault.textFieldBorderColor
    public var textFieldBgColor = KAlertViewDefault.textFieldBgColor
    public var textFieldFont = KAlertViewDefault.textFieldFont
    
    public var textFields: [UITextField] = []
    public var textFieldSeparateViews: [UIView] = []
    public var buttons: [UIButton] = []
    public var actions: [KAlertAction] = []
    
    public var clickedAutoHide: Bool = true
    
//MARK: - publicFunc
    public func add(action: KAlertAction) {
        _add(action: action)
    }
    
    public func addTextField(configHandler: ((UITextField)->())?) {
        _addTextField(configHandler: configHandler)
    }
    
//MARK: - override
    override public func didMoveToSuperview() {
        if self.superview != nil {
            layoutContentViews()
            layoutTextLabels()
        }
    }
//MARK: - action
    @objc private func actionButtonClicked(_ button: UIButton) {
        let action = actions[button.tag - KAlertViewDefault.buttonTagOffset]
        
        if clickedAutoHide {
            hide()
        }
        action.handler?(action)
    }
    
//MARK: - privateFunc
    private func _add(action: KAlertAction) {
        let button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.layer.cornerRadius = buttonCornerRadius
        button.setTitle(action.title, for: .normal)
        button.titleLabel?.font = buttonFont
        button.backgroundColor = buttonBgColor(style: action.style)
        //        button.isEnabled = action.
        button.tag = KAlertViewDefault.buttonTagOffset + buttons.count
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(actionButtonClicked(_:)), for: .touchUpInside)
        
        buttonContentView.addSubview(button)
        buttons.append(button)
        actions.append(action)
        if buttons.count == 1 {
            layoutContentViews()
            layoutTextLabels()
        }
        layoutButtons()
    }
    
    private func _addTextField(configHandler: ((UITextField)->())?) {
        let textField = UITextField()
        textField.tag = KAlertViewDefault.textFieldOffset + textFields.count
        textField.font = textFieldFont
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        configHandler?(textField)
        
        textFieldContentView.addSubview(textField)
        textFields.append(textField)
        
        if textFields.count > 1 {
            let separateView = UIView()
            separateView.backgroundColor = textFieldBorderColor
            separateView.translatesAutoresizingMaskIntoConstraints = false
            textFieldContentView.addSubview(separateView)
            textFieldSeparateViews.append(separateView)
        }
        
        layoutTextFields()
    }
    
    private func configProperties() {
        backgroundColor = UIColor.white
    }
    
    private func buttonBgColor(style: KAlertActionStyle) -> UIColor {
        switch style {
        case .cancel:
            return KAlertViewDefault.buttonCancelBgColor
        case .destructive:
            return KAlertViewDefault.buttonDestructiveBgColor
        default:
            return KAlertViewDefault.buttonDefaultBgColor
        }
    }
    
    private func addContentViews() {
        addSubview(textContentView)
        addSubview(textFieldContentView)
        addSubview(buttonContentView)
        buttonContentView.isUserInteractionEnabled = true
    }
    
    private func addTextLabels() {
        titleLabel.textAlignment = .center
        titleLabel.font = titleFont
        titleLabel.textColor = titleColor
        textContentView.addSubview(titleLabel)
        
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = messageFont
        messageLabel.textColor = messageColor
        textContentView.addSubview(messageLabel)
    }
    
    private func layoutContentViews() {
        guard textContentView.translatesAutoresizingMaskIntoConstraints else {
            return // layout completed
        }
        
        self.addConstraint(width: alertViewWidth, height: 0)
        
        // textContentView
        textContentView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraintWith(view: textContentView, topView: self, leftView: self, bottomView: nil, rightView: self, edgeInsert: UIEdgeInsets(top: contentViewSpace, left: textLabelContentViewEdge, bottom: 0, right: -textLabelContentViewEdge))
        
        // textFieldContentView
        textFieldContentView.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldTopConstraint = addConstraint(topView: textContentView, bottomView: textFieldContentView, constant: 0)
        addConstraintWith(view: textFieldContentView, topView: nil, leftView: self, bottomView: nil, rightView: self, edgeInsert: UIEdgeInsets(top: 0, left: textFieldContentViewEdge, bottom: 0, right: -textFieldContentViewEdge))
        
        // buttonContentView
        buttonContentView.translatesAutoresizingMaskIntoConstraints = false
        buttonTopConstraint = addConstraint(topView: textFieldContentView, bottomView: buttonContentView, constant: buttonContentViewTop)
        addConstraintWith(view: buttonContentView, topView: nil, leftView: self, bottomView: self, rightView: self, edgeInsert: UIEdgeInsets(top: 0, left: buttonContentViewEdge, bottom: -contentViewSpace, right: -buttonContentViewEdge))
        
    }
    
    private func layoutTextLabels() {
        guard titleLabel.translatesAutoresizingMaskIntoConstraints &&
            messageLabel.translatesAutoresizingMaskIntoConstraints else {
            return // layout completed
        }
        
        // title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textContentView.addConstraintWith(view: titleLabel, topView: textContentView, leftView: textContentView, bottomView: nil, rightView: textContentView, edgeInsert: UIEdgeInsets.zero)
        
        // message
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        textContentView.addConstraintWith(view: messageLabel, topView: nil, leftView: textContentView, bottomView: textContentView, rightView: textContentView, edgeInsert: UIEdgeInsets.zero)
        textContentView.addConstraint(topView: titleLabel, bottomView: messageLabel, constant: textLabelSpace)
    }
    
    private func layoutButtons() {
        guard buttons.count > 0 else { return }
        
        let button = buttons.last!
        
        if buttons.count == 1 {
            buttonTopConstraint?.constant = -buttonContentViewTop
            buttonContentView.addConstraintWith(view: button, topView: buttonContentView, leftView: buttonContentView, bottomView: buttonContentView, rightView: buttonContentView, edgeInsert: UIEdgeInsets.zero)
            button.addConstraint(width: 0, height: buttonHeight)
        } else if buttons.count == 2 {
            let firstButton = buttons.first!
            buttonContentView.removeConstraint(view: firstButton, attribute: .right)
            buttonContentView.addConstraintWith(view: button, topView: buttonContentView, leftView: nil, bottomView: nil, rightView: buttonContentView, edgeInsert: UIEdgeInsets.zero)
            buttonContentView.addConstraint(leftView: firstButton, rightView: button, constant: buttonSpace)
            buttonContentView.addConstraintEqual(view: button, widthView: firstButton, heightView: firstButton)
        } else {
            if buttons.count == 3 {
                let firstButton = buttons.first!
                let secondButton = buttons[1]
                buttonContentView.removeConstraint(view: firstButton, attribute: .right)
                buttonContentView.removeConstraint(view: firstButton, attribute: .bottom)
                buttonContentView.removeConstraint(view: secondButton, attribute: .top)
                buttonContentView.addConstraintWith(view: firstButton, topView: nil, leftView: nil, bottomView: nil, rightView: buttonContentView, edgeInsert: UIEdgeInsets.zero)
                buttonContentView.addConstraint(topView: firstButton, bottomView: secondButton, constant: buttonSpace)
            }
            
            let lastSecondButton = buttons[buttons.count-2]
            buttonContentView.removeConstraint(view: lastSecondButton, attribute: .bottom)
            buttonContentView.addConstraint(topView: lastSecondButton, bottomView: button, constant: buttonSpace)
            buttonContentView.addConstraintWith(view: button, topView: nil, leftView: buttonContentView, bottomView: buttonContentView, rightView: buttonContentView, edgeInsert: UIEdgeInsets.zero)
            buttonContentView.addConstraintEqual(view: button, widthView: nil, heightView: lastSecondButton)
        }
    }
    
    private func layoutTextFields() {
        guard textFields.count > 0 else { return }
        
        let textField = textFields.last!
        
        if textFields.count == 1 {
            textFieldContentView.backgroundColor = textFieldBgColor
            textFieldContentView.layer.masksToBounds = true
            textFieldContentView.layer.cornerRadius = 4
            textFieldContentView.layer.borderWidth = textFieldBorderWidth
            textFieldContentView.layer.borderColor = textFieldBorderColor.cgColor
            textFieldTopConstraint?.constant = -contentViewSpace
            textFieldContentView.addConstraintWith(view: textField, topView: textFieldContentView, leftView: textFieldContentView, bottomView: textFieldContentView, rightView: textFieldContentView, edgeInsert: UIEdgeInsets(top: textFieldBorderWidth, left: textFieldEdge, bottom: -textFieldBorderWidth, right: -textFieldEdge))
            textField.addConstraint(width: 0, height: textFieldHeight)
        } else {
            // textField
            let lastSecondTextField = textFields[textFields.count-2]
            textFieldContentView.removeConstraint(view: lastSecondTextField, attribute: .bottom)
            textFieldContentView.addConstraint(topView: lastSecondTextField, bottomView: textField, constant: textFieldBorderWidth)
            textFieldContentView.addConstraintWith(view: textField, topView: nil, leftView: textFieldContentView, bottomView: textFieldContentView, rightView: textFieldContentView, edgeInsert: UIEdgeInsets(top: 0, left: textFieldEdge, bottom: -textFieldBorderWidth, right: -textFieldEdge))
            textFieldContentView.addConstraintEqual(view: textField, widthView: nil, heightView: lastSecondTextField)
            
            // separateView
            let separateView = textFieldSeparateViews[textFields.count - 2]
            textFieldContentView.addConstraintWith(view: separateView, topView: nil, leftView: textFieldContentView, bottomView: nil, rightView: textFieldContentView, edgeInsert: UIEdgeInsets.zero)
            textFieldContentView.addConstraint(topView: separateView, bottomView: textField, constant: 0)
            separateView.addConstraint(width: 0, height: textFieldBorderWidth)
        }
    }
    
//MARK: - private / lazy
    private var textFieldTopConstraint: NSLayoutConstraint?
    private var buttonTopConstraint: NSLayoutConstraint?
    private lazy var textContentView = UIView()
    private lazy var textFieldContentView = UIView()
    private lazy var buttonContentView = UIView()
    
}

extension KAlertView {
    
    func viewController() -> UIViewController? {
        var nextResponder = self.next
        while true {
            let responder = nextResponder?.next
            guard responder != nil else { return nil }
            
            if responder!.isKind(of: UIViewController.self) {
                return responder as? UIViewController
            }
            nextResponder = responder
        }
    }
    
    func hide() {
        if self.viewController() is KAlertController {
            self.viewController()?.dismiss(animated: true, completion: nil)
        }
    }
}
