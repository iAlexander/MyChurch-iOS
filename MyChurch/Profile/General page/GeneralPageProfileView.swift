//
//  GeneralPageProfileView.swift
//  MyChurch
//
//  Created by Zhekon on 27.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class GeneralPageProfileView: UIView {
    
    let topBackView = UIView()
    let peopleType = UILabel()
    let nameSername = UILabel()
    
    let changeEmail = UIButton()
    let changeEmailLabel = UILabel()
    let changeEmailGrayLine = UIView()
    let rightArrowEmail = UIImageView()
    
    let changePassword = UIButton()
    let changePasswordGrayLine = UIView()
    let changePasswordLabel = UILabel()
    let rightArrowPassword = UIImageView()
    
    let startScreenLabel = UILabel()
    
    private let startScreenView = UIView()
    let startScreenButtonText = UILabel()
    let startScreenButton = UIButton()
    private let startScreenImage = UIImageView()
    
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
        
        addSubview(topBackView)
        topBackView.backgroundColor = UIColor(red: 0.949, green: 0.976, blue: 0.996, alpha: 1)
        
        topBackView.addSubview(peopleType)
        peopleType.text = "Вiрянин"
        peopleType.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        peopleType.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        topBackView.addSubview(nameSername)
        nameSername.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        nameSername.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        addSubview(changeEmail)
        
        changeEmail.addSubview(changeEmailLabel)
        changeEmailLabel.text = "Змiна email"
        changeEmailLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        changeEmailLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        changeEmailLabel.textAlignment = .left
        
        addSubview(changeEmailGrayLine)
        changeEmailGrayLine.backgroundColor =  UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        changeEmail.addSubview(rightArrowEmail)
        rightArrowEmail.image = UIImage(named: "rightArrowBlue")
        rightArrowEmail.contentMode = .scaleAspectFit
        
        addSubview(changePassword)
        
        addSubview(changePasswordGrayLine)
        changePasswordGrayLine.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        changePassword.addSubview(changePasswordLabel)
        changePasswordLabel.text = "Зміна паролю"
        changePasswordLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        changePasswordLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        changePasswordLabel.textAlignment = .left
        
        changePassword.addSubview(rightArrowPassword)
        rightArrowPassword.image = UIImage(named: "rightArrowBlue")
        rightArrowPassword.contentMode = .scaleAspectFit
        
        addSubview(startScreenLabel)
        startScreenLabel.text = "Cтартовий екран"
        startScreenLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        startScreenLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        startScreenLabel.textAlignment = .left
        
        addSubview( startScreenView)
        
        startScreenView.layer.backgroundColor = UIColor(red: 0.949, green: 0.976, blue: 0.996, alpha: 1).cgColor
        startScreenView.layer.cornerRadius = 10
        
        startScreenView.addSubview(startScreenButtonText)
      
        startScreenButtonText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        startScreenButtonText.textAlignment = .left
        startScreenButtonText.textColor = .black
        
        startScreenView.addSubview(   startScreenImage)
    //    startScreenImage.image = UIImage(named: "searchIcon")
        startScreenImage.contentMode = .scaleAspectFill
        
        startScreenView.addSubview(startScreenButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topBackView.pin.horizontally().top().height(85)
        peopleType.pin.top(15).horizontally(15).height(20)
        nameSername.pin.below(of: peopleType).marginTop(8).left(15).right().height(25)
        changeEmail.pin.below(of: nameSername).horizontally().height(85)
        changeEmailLabel.pin.top(35).horizontally(15).bottom(15)
        rightArrowEmail.pin.right(15).top(45).width(10).bottom(25)
        changeEmailGrayLine.pin.below(of: changeEmail).height(0.25).horizontally()
        
        changePassword.pin.below(of: changeEmailGrayLine).horizontally().height(85)
        changePasswordGrayLine.pin.below(of: changePassword).height(0.25).horizontally()
        changePasswordLabel.pin.top(35).horizontally(15).bottom(15)
        rightArrowPassword.pin.right(15).top(45).width(10).bottom(25)
        
        startScreenLabel.pin.below(of: changePasswordGrayLine).marginTop(15).left(15).right().height(25)
        
        startScreenView.pin.below(of: startScreenLabel).marginTop(5).horizontally(15).height(50)
        startScreenButton.pin.all()
        startScreenButtonText.pin.left(15).vertically(13).right(75)
        startScreenImage.pin.right(15).vertically(15).width(20)
    }
}
