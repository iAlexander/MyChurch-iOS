//
//  LoginView.swift
//  MyChurch
//
//  Created by Zhekon on 28.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    let topTextLabel = UILabel()
    let emailTopText = UILabel()
    let emailField = UITextField()
    private let emailGrayLine = UIView()
    let topTextPassword = UILabel()
    let passwordField = UITextField()
    private let passGrayLine = UIView()
    let remindPasswordButton = UIButton()
    let remindPasswordLabel = UILabel()
    let enterButton = UIButton()
    private let enterBlueLayer = CAGradientLayer()
    let createAccount = UIButton()
    let createAccountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .white
        
        addSubview(topTextLabel)
        topTextLabel.text = "Вхід до кабінету"
        topTextLabel.textAlignment = .center
        topTextLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        topTextLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        addSubview(emailTopText)
        emailTopText.text = "Ел. адреса"
        emailTopText.textAlignment = .left
        emailTopText.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        emailTopText.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        addSubview(emailField)
        emailField.autocorrectionType = .no
        
        addSubview(emailGrayLine)
        emailGrayLine.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        addSubview(topTextPassword)
        topTextPassword.text = "Пароль"
        topTextPassword.textAlignment = .left
        topTextPassword.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        topTextPassword.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        addSubview(passwordField)
        passwordField.autocorrectionType = .no
        passwordField.isSecureTextEntry = true
        
        addSubview(passGrayLine)
        passGrayLine.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        addSubview(remindPasswordButton)
        
        remindPasswordButton.addSubview(remindPasswordLabel)
        remindPasswordLabel.attributedText = NSAttributedString(string: "Нагадати пароль", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        remindPasswordLabel.textColor = UIColor(red: 0.008, green: 0.529, blue: 0.918, alpha: 1)
        remindPasswordLabel.textAlignment = .left
        remindPasswordLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        enterBlueLayer.colors = [
            UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1).cgColor,
            UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1).cgColor
        ]
        enterBlueLayer.locations = [0, 1]
        enterBlueLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        enterBlueLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        enterBlueLayer.cornerRadius = 10
        enterBlueLayer.position = enterButton.center
        enterButton.layer.addSublayer(enterBlueLayer)
        enterButton.setTitle("Увiйти", for: .normal)
        addSubview(enterButton)
        
        addSubview(createAccount)
        
        createAccount.addSubview(createAccountLabel)
        createAccountLabel.attributedText = NSAttributedString(string: "Створити особистий кабінет", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        createAccountLabel.textColor = UIColor(red: 0.008, green: 0.529, blue: 0.918, alpha: 1)
        createAccountLabel.textAlignment = .left
        createAccountLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topTextLabel.pin.top(45).horizontally().height(25)
        emailTopText.pin.below(of: topTextLabel).marginTop(45).horizontally(15).height(20)
        emailField.pin.below(of: emailTopText).marginTop(5).horizontally(15).height(20)
        emailGrayLine.pin.below(of: emailField).horizontally(15).height(1.5)
        
        topTextPassword.pin.below(of: emailGrayLine).marginTop(40).horizontally(15).height(20)
        passwordField.pin.below(of: topTextPassword).marginTop(5).horizontally(15).height(20)
        passGrayLine.pin.below(of: passwordField).horizontally(15).height(1.5)
        
        remindPasswordButton.pin.below(of: passGrayLine).marginTop(20).left(15).width(125).height(20)
        remindPasswordLabel.pin.all()
        
        enterButton.pin.below(of: remindPasswordButton).marginTop(40).horizontally(15).height(40)
        enterBlueLayer.pin.all()
        
        createAccount.pin.below(of: enterButton).marginTop(50).height(25).hCenter().width(250)
        createAccountLabel.pin.all()
    }
}
