//
//  ChacngeEmailVIew.swift
//  MyChurch
//
//  Created by Zhekon on 01.04.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class ChangeEmailView: UIView {
    
    let oldPassLabel = UILabel()
    let oldPassField = UITextField()
    let oldPassGrayLine = UIView()
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
        oldPassLabel.text = "Введiть новий email"
        oldPassLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        oldPassLabel.textAlignment = .left
        oldPassLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        addSubview(oldPassField)
        oldPassField.autocorrectionType = .no
        
        addSubview(oldPassGrayLine)
        oldPassGrayLine.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
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
        enterButton.setTitle("Змінити email", for: .normal)
        addSubview(enterButton)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        oldPassLabel.pin.top(35).horizontally(15).height(20)
        oldPassField.pin.below(of: oldPassLabel).marginTop(5).horizontally(15).height(20)
        oldPassGrayLine.pin.below(of: oldPassField).horizontally(15).height(0.25)
        enterButton.pin.below(of: oldPassGrayLine).marginTop(50).horizontally(15).height(40)
        enterBlueLayer.pin.all()
    }
}
