//
//  RegistrationFifthPageView.swift
//  MyChurch
//
//  Created by Zhekon on 21.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class RegistrationFifthPageView: UIView {
    
    let topGoldenLine = UIView()
    private let layerGolden = CAGradientLayer()
    let writePhoneTopLabel = UILabel()
    let codeField = UITextField()
    let firstSymbolCode = UIImageView()
    let secondSymbolCode = UIImageView()
    let thirdSymbolCode = UIImageView()
    let fourthSymbolCode = UIImageView()
    let fifthSymbolCode = UIImageView()
    let sixthSymbolCode = UIImageView()
    let passTextLabel = UILabel()
    
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
        
        writePhoneTopLabel.font =  UIFont.systemFont(ofSize: 22, weight: .bold)
        writePhoneTopLabel.text = "Вигадайте пароль"
        writePhoneTopLabel.numberOfLines = 0
        writePhoneTopLabel.textAlignment = .center
        addSubview(writePhoneTopLabel)
        
        codeField.keyboardType = .phonePad
        addSubview(codeField)
        
        firstSymbolCode.image = UIImage(named: "passLock")
        addSubview(firstSymbolCode)
        
        secondSymbolCode.image = UIImage(named: "passLock")
        addSubview(secondSymbolCode)
        
        thirdSymbolCode.image = UIImage(named: "passLock")
        addSubview(thirdSymbolCode)
        
        fourthSymbolCode.image = UIImage(named: "passLock")
        addSubview(fourthSymbolCode)
        
        fifthSymbolCode.image = UIImage(named: "passLock")
        addSubview(fifthSymbolCode)
        
        sixthSymbolCode.image = UIImage(named: "passLock")
        addSubview(sixthSymbolCode)
        
        
        passTextLabel.text = "Запам’ятайте пароль для\n подальшого входу в Профіль"
        passTextLabel.font =  UIFont.systemFont(ofSize: 18, weight: .regular)
        passTextLabel.numberOfLines = 0
        passTextLabel.textAlignment = .center
        addSubview(passTextLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let currentWidth = UIScreen.main.bounds.size.width
        topGoldenLine.pin.top().left().height(10).width(currentWidth * 0.95)
        layerGolden.pin.all()
        writePhoneTopLabel.pin.top(30).height(75).width(250).hCenter()
        codeField.pin.below(of: writePhoneTopLabel).horizontally(20).height(20).marginTop(20)
        firstSymbolCode.pin.below(of: writePhoneTopLabel).marginTop(25).height(16).width(16).left(to:writePhoneTopLabel.edge.left).marginLeft(35)
        secondSymbolCode.pin.below(of: writePhoneTopLabel).marginTop(25).height(16).width(16).left(to:firstSymbolCode.edge.right).marginLeft(15)
        thirdSymbolCode.pin.below(of: writePhoneTopLabel).marginTop(25).height(16).width(16).left(to:secondSymbolCode.edge.right).marginLeft(15)
        fourthSymbolCode.pin.below(of: writePhoneTopLabel).marginTop(25).height(16).width(16).left(to:thirdSymbolCode.edge.right).marginLeft(15)
        fifthSymbolCode.pin.below(of: writePhoneTopLabel).marginTop(25).height(16).width(16).left(to:fourthSymbolCode.edge.right).marginLeft(15)
        sixthSymbolCode.pin.below(of: writePhoneTopLabel).marginTop(25).height(16).width(16).left(to:fifthSymbolCode.edge.right).marginLeft(15)
        passTextLabel.pin.below(of: sixthSymbolCode).marginTop(65).horizontally(40).height(45)
    }
}
