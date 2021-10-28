//
//  GeneralPageProfileView.swift
//  MyChurch
//
//  Created by Zhekon on 27.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class GeneralPageProfileView: UIView {
    
    let scroll = UIScrollView()
    
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
    
    let exitButton = UIButton()
    let bottomText = UILabel()
    
    let donateView = UIButton()
    let rightArrowDonate = UIImageView()
    let donateText = UILabel()
    let regularText = UILabel()
    let donateBottomLine = UIView()
    
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
        
        addSubview(scroll)
        
        scroll.addSubview(topBackView)
        topBackView.backgroundColor = UIColor(red: 0.949, green: 0.976, blue: 0.996, alpha: 1)
        
        topBackView.addSubview(peopleType)
        peopleType.text = ""
        peopleType.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        peopleType.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        topBackView.addSubview(nameSername)
        nameSername.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        nameSername.textColor = .darkGray
        
        scroll.addSubview(changeEmail)
        
        changeEmail.addSubview(changeEmailLabel)
        changeEmailLabel.text = "Змiна email"
        changeEmailLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        changeEmailLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        changeEmailLabel.textAlignment = .left
        
        scroll.addSubview(changeEmailGrayLine)
        changeEmailGrayLine.backgroundColor =  UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        changeEmail.addSubview(rightArrowEmail)
        rightArrowEmail.image = UIImage(named: "rightArrowBlue")
        rightArrowEmail.contentMode = .scaleAspectFit
        
        scroll.addSubview(changePassword)
        
        scroll.addSubview(changePasswordGrayLine)
        changePasswordGrayLine.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        changePassword.addSubview(changePasswordLabel)
        changePasswordLabel.text = "Зміна паролю"
        changePasswordLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        changePasswordLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        changePasswordLabel.textAlignment = .left
        
        changePassword.addSubview(rightArrowPassword)
        rightArrowPassword.image = UIImage(named: "rightArrowBlue")
        rightArrowPassword.contentMode = .scaleAspectFit
        
        scroll.addSubview(startScreenLabel)
        startScreenLabel.text = "Cтартовий екран"
        startScreenLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        startScreenLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        startScreenLabel.textAlignment = .left
        
        scroll.addSubview( startScreenView)
        
        startScreenView.layer.backgroundColor = UIColor(red: 0.949, green: 0.976, blue: 0.996, alpha: 1).cgColor
        startScreenView.layer.cornerRadius = 10
        
        startScreenView.addSubview(startScreenButtonText)
      
        startScreenButtonText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        startScreenButtonText.textAlignment = .left
        startScreenButtonText.textColor = .black
        
        startScreenView.addSubview(   startScreenImage)
        startScreenImage.image = UIImage(named: "topArrow")?.withRenderingMode(.alwaysTemplate)
        startScreenImage.tintColor = .gray
        startScreenImage.transform = CGAffineTransform(rotationAngle: .pi)
        startScreenView.addSubview(startScreenButton)
        
        scroll.addSubview(exitButton)
        exitButton.setTitle("Вийти", for: .normal)
        exitButton.setTitleColor(.red, for: .normal)
        
        scroll.addSubview(bottomText)
        bottomText.textColor = .lightGray
        bottomText.text = "Розроблено D2"
        bottomText.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        scroll.addSubview(donateView)
        donateView.addSubview(donateText)
        donateText.text = "Благодiйний внесок"
        donateText.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        donateText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        donateText.textAlignment = .left
        
        donateView.addSubview(rightArrowDonate)
        rightArrowDonate.image = UIImage(named: "rightArrowBlue")
        rightArrowDonate.contentMode = .scaleAspectFit
        
        donateView.addSubview(regularText)
        regularText.text = "регулярнi платежi"
         regularText.font = UIFont.systemFont(ofSize: 12, weight: .regular)
         regularText.textColor = UIColor(red: 0.529, green: 0.572, blue: 0.63, alpha: 1)
         regularText.textAlignment = .left
        
        scroll.addSubview(donateBottomLine)
        donateBottomLine.backgroundColor =  UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scroll.pin.all()
        topBackView.pin.horizontally().top().height(85)
        peopleType.pin.top(15).horizontally(15).height(20)
        nameSername.pin.below(of: peopleType).marginTop(8).left(15).right().height(25)
        changeEmail.pin.below(of: topBackView).horizontally().height(85)
        changeEmailLabel.pin.verticallyBetween(topBackView, and: changeEmailGrayLine).horizontally(15)
        rightArrowEmail.pin.right(15).width(10).vertically()
        changeEmailGrayLine.pin.below(of: changeEmail).height(0.25).horizontally()
        changePassword.pin.below(of: changeEmailGrayLine).horizontally().height(85)
        changePasswordGrayLine.pin.below(of: changePassword).height(0.25).horizontally()
        changePasswordLabel.pin.verticallyBetween(changeEmailGrayLine, and: changePasswordGrayLine).horizontally(15)
        rightArrowPassword.pin.right(15).width(10).vertically()
        donateView.pin.below(of: changePasswordGrayLine).marginTop(5).horizontally().height(85)
        rightArrowDonate.pin.right(15).width(10).vertically()
        donateText.pin.verticallyBetween(changePasswordGrayLine, and: donateBottomLine).horizontally(15).marginTop(-10)
        regularText.pin.below(of: donateText).horizontally(15).height(15).marginTop(-38)
        donateBottomLine.pin.below(of: donateView).height(0.25).horizontally()
        
        startScreenLabel.pin.below(of: donateView).marginTop(15).left(15).right().height(25)

        startScreenView.pin.below(of: startScreenLabel).marginTop(5).horizontally(15).height(50)
        startScreenButton.pin.all()
        startScreenButtonText.pin.left(15).vertically(13).right(75)
        startScreenImage.pin.right(20).vCenter().width(16).height(10)
        exitButton.pin.below(of: startScreenView).marginTop(50).left(15).width(65).height(20)
        bottomText.pin.bottom(20).right(10).height(20).width(105)
        scroll.contentSize = CGSize(width: self.frame.size.width, height: bottomText.frame.maxY + 20)
    }
}
