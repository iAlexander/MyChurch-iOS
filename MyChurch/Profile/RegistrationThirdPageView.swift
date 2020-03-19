//
//  RegistrationThirdPageView.swift
//  MyChurch
//
//  Created by Zhekon on 19.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class RegistrationThirdPageView: UIView {
    
    let topGoldenLine = UIView()
    private let layerGolden = CAGradientLayer()
    private let writePhoneTopLabel = UILabel()
    private let phoneNumberTextLabel = UILabel()
    let numberTextField = UITextField()
    private let phoneFieldBlackLine = UIView()
    let sendCodeButton = UIButton()
    
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
        
        addSubview(topGoldenLine)
        layerGolden.colors = [
            UIColor(red: 0.95, green: 0.745, blue: 0.218, alpha: 1).cgColor,
            UIColor(red: 0.938, green: 0.838, blue: 0.313, alpha: 1).cgColor
        ]
        layerGolden.locations = [0, 1]
        layerGolden.startPoint = CGPoint(x: 0.5, y: 0.25)
        layerGolden.endPoint = CGPoint(x: 0.5, y: 0.75)
        layerGolden.position = topGoldenLine.center
        topGoldenLine.layer.addSublayer(layerGolden)
        
        writePhoneTopLabel.text = "Введіть номер телефону"
        writePhoneTopLabel.font =  UIFont.systemFont(ofSize: 22, weight: .bold)
        writePhoneTopLabel.textAlignment = .center
        addSubview(writePhoneTopLabel)

        phoneNumberTextLabel.text = "Номер телефону"
        phoneNumberTextLabel.font =  UIFont.systemFont(ofSize: 12, weight: .regular)
        phoneNumberTextLabel.textAlignment = .left
        phoneNumberTextLabel.textColor = UIColor(red: 0.529, green: 0.572, blue: 0.63, alpha: 1)
        addSubview(phoneNumberTextLabel)
        
        numberTextField.keyboardType = .phonePad
        numberTextField.text = "+38 (0"
        addSubview(numberTextField)
        
        phoneFieldBlackLine.backgroundColor = .black
        addSubview(phoneFieldBlackLine)
        
        sendCodeButton.layer.backgroundColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
        sendCodeButton.layer.cornerRadius = 10
        sendCodeButton.setTitle("Відправити код", for: .normal)
        addSubview(sendCodeButton)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let currentWidth = UIScreen.main.bounds.size.width
        topGoldenLine.pin.top(0).left().height(10).width(currentWidth / 3)
        layerGolden.pin.all()
        writePhoneTopLabel.pin.top(30).horizontally(20).height(28)
        phoneNumberTextLabel.pin.below(of: writePhoneTopLabel).marginTop(30).horizontally(15).height(15)
        numberTextField.pin.below(of: phoneNumberTextLabel).marginTop(5).height(20).horizontally(15)
        phoneFieldBlackLine.pin.below(of: numberTextField).horizontally(15).height(2).marginTop(5)
        sendCodeButton.pin.below(of: phoneFieldBlackLine).marginTop(35).horizontally(15).height(40)
    }
}
