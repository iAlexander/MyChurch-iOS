//
//  ChacngePasswordVIew.swift
//  MyChurch
//
//  Created by Zhekon on 29.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class ChacngePasswordVIew: UIView {
    
    let oldPassLabel = UILabel()
    let oldPassField = UITextField()
    let oldPassGrayLine = UIView()
    let remindPasswordButton = UIButton()
    let remindPasswordLabel = UILabel()
    let newPassLabel = UILabel()
    let newPassField = UITextField()
    let newPassGrayLine = UIView()
    let enterButton = UIButton()
    private let enterBlueLayer = CAGradientLayer()
    
    
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
        
        addSubview(oldPassLabel)
        oldPassLabel.text = "Cтарий пароль"
        oldPassLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        oldPassLabel.textAlignment = .left
        oldPassLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        addSubview(oldPassField)
        oldPassField.autocorrectionType = .no
        oldPassField.isSecureTextEntry = true
        
        addSubview(oldPassGrayLine)
        oldPassGrayLine.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        addSubview(remindPasswordButton)
        
        remindPasswordButton.addSubview(remindPasswordLabel)
        remindPasswordLabel.attributedText = NSAttributedString(string: "Нагадати пароль", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        remindPasswordLabel.textColor = UIColor(red: 0.008, green: 0.529, blue: 0.918, alpha: 1)
        remindPasswordLabel.textAlignment = .left
        remindPasswordLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        addSubview(newPassLabel)
        newPassLabel.text = "Новий пароль"
        newPassLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        newPassLabel.textAlignment = .left
        newPassLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        addSubview(newPassField)
        newPassField.autocorrectionType = .no
        newPassField.isSecureTextEntry = true
        
        addSubview(newPassGrayLine)
        newPassGrayLine.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
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
        enterButton.setTitle("Змінити пароль", for: .normal)
        addSubview(enterButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        oldPassLabel.pin.top(85).horizontally(15).height(20)
        oldPassField.pin.below(of: oldPassLabel).marginTop(5).horizontally(15).height(20)
        oldPassGrayLine.pin.below(of: oldPassField).horizontally(15).height(0.25)
        remindPasswordButton.pin.below(of: oldPassGrayLine).marginTop(25).left(15).height(20).width(125)
        remindPasswordLabel.pin.all()
        
        newPassLabel.pin.below(of: remindPasswordLabel).marginTop(50).horizontally(15).height(20)
        newPassField.pin.below(of: newPassLabel).marginTop(5).horizontally(15).height(20)
        newPassGrayLine.pin.below(of: newPassField).horizontally(15).height(0.25)
        enterButton.pin.below(of: newPassGrayLine).marginTop(75).horizontally(15).height(40)
        enterBlueLayer.pin.all()
    }
}
