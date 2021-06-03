//
//  RegularDonateView.swift
//  MyChurch
//
//  Created by Zhekon on 10.08.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class RegularDonateView: UIView {
    
    let topBackView = UIView()
    let peopleType = UILabel()
    let nameSername = UILabel()
    let durationLabel = UILabel()
    let personInfoButton = UIButton()
    let personInfoLabel = UILabel()
    let arrowImage =  UIImageView()
    let bottomGrayLine = UIView()
    let subscribeButton = UIButton()
    let moneyField = CurrencyTextField()
    let summasLabel = UILabel()
    let needDonateLabel = UILabel()

    let backView = UIView()
    let nameChurch = UILabel()
    let churchLabel = UILabel()
    let churchLine = UIView()
    let emailLabel = UILabel()
    let emailData = UILabel()
    let emailLine = UIView()
    let mapImage = UIImageView()
    let distriction = UILabel()
    let historyTable = UITableView()
    
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
        peopleType.text = "Фінансова установа, що приймає платежі"
        peopleType.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        peopleType.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        topBackView.addSubview(nameSername)
        nameSername.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        nameSername.textColor = UIColor.black
        nameSername.text = "LiqPay"
        
        addSubview(durationLabel)
        durationLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        durationLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        durationLabel.text = "Періодичність платежів складає 1 р/міс."
        
        addSubview(personInfoButton)
        personInfoButton.layer.backgroundColor = UIColor(red: 0.949, green: 0.976, blue: 0.996, alpha: 1).cgColor
        personInfoButton.layer.cornerRadius = 10
        
        personInfoButton.addSubview(personInfoLabel)
        personInfoLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        personInfoLabel.text = "Контакти юридичної особи"
        personInfoLabel.textColor = .black
        personInfoLabel.textAlignment = .left
        
        personInfoButton.addSubview(arrowImage)
        arrowImage.image = UIImage(named: "topArrow")
        
        addSubview(bottomGrayLine)
        bottomGrayLine.backgroundColor =  UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        addSubview(subscribeButton)
        subscribeButton.setTitle("Пiдписатись", for: .normal)
        subscribeButton.backgroundColor =  UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1)
        
        addSubview(moneyField)
        moneyField.placeholder = "0.00"
        moneyField.keyboardType = .numberPad
        
        addSubview(summasLabel)
        summasLabel.text = "Зазначте сумму (грн):"
        summasLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        summasLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        summasLabel.textAlignment = .left
        
        addSubview(needDonateLabel)
        needDonateLabel.text = "Робити благодійні внески щомісяця?"
        needDonateLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        needDonateLabel.textColor = .black
        needDonateLabel.textAlignment = .left
        
        addSubview(backView)
        backView.backgroundColor = .white
        backView.addSubview(nameChurch)
        nameChurch.text = "Назва установи"
        nameChurch.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        nameChurch.textColor = UIColor(red: 0.529, green: 0.572, blue: 0.63, alpha: 1)
        nameChurch.textAlignment = .left
        
        backView.addSubview(churchLabel)
        churchLabel.text = "Православна Церква України"
        churchLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        churchLabel.textColor = .black
        churchLabel.textAlignment = .left
        
        backView.addSubview(emailLabel)
        emailLabel.text = "Ел. адреса"
        emailLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        emailLabel.textColor = UIColor(red: 0.529, green: 0.572, blue: 0.63, alpha: 1)
        emailLabel.textAlignment = .left
        
        backView.addSubview(churchLine)
        churchLine.backgroundColor =  UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        backView.addSubview(emailData)
        emailData.text = "support@pomisna.info"
        emailData.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        emailData.textColor = .black
        emailData.textAlignment = .left
        
        backView.addSubview(emailLine)
        emailLine.backgroundColor =  UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        backView.addSubview(mapImage)
        mapImage.image = UIImage(named: "detailMarker")
        
        backView.addSubview(distriction)
        distriction.text = "м. Київ, вул. Трьохсвятительська, 8"
        distriction.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        distriction.textColor = .black
        distriction.textAlignment = .left
        
        addSubview(historyTable)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topBackView.pin.horizontally().top().height(85)
        peopleType.pin.top(15).horizontally(15).height(20)
        nameSername.pin.below(of: peopleType).marginTop(8).left(15).right().height(25)
        durationLabel.pin.below(of: topBackView).marginTop(15).horizontally(15).height(20)
        personInfoButton.pin.below(of: durationLabel).marginTop(10).horizontally(15).height(50)
        personInfoLabel.pin.left(15).vCenter().height(50).right(50)
        arrowImage.pin.right(20).vCenter().width(16).height(10)
      
        subscribeButton.pin.bottom().horizontally().height(45)
        historyTable.pin.below(of: personInfoButton).horizontally().bottom(to:subscribeButton.edge.top).marginBottom(5)
        bottomGrayLine.pin.above(of: subscribeButton).horizontally(15).height(0.5).marginBottom(20)
        moneyField.pin.above(of: bottomGrayLine).horizontally(15).height(20).marginBottom(5)
        summasLabel.pin.above(of: moneyField).horizontally(15).height(15).marginBottom(5)
        needDonateLabel.pin.above(of: summasLabel).horizontally(15).height(15).marginBottom(5)
        
        backView.pin.below(of: personInfoButton).marginTop(10).horizontally().above(of: subscribeButton).marginBottom(15)
        nameChurch.pin.top(10).horizontally(15).height(20)
        churchLabel.pin.below(of: nameChurch).marginTop(10).horizontally(15).height(20)
        churchLine.pin.below(of: churchLabel).marginTop(5).horizontally(15).height(0.5)
        emailLabel.pin.below(of: churchLine).marginTop(10).horizontally(15).height(20)
        emailData.pin.below(of: emailLabel).marginTop(5).horizontally(15).height(20)
        emailLine.pin.below(of: emailData).marginTop(5).horizontally(15).height(0.5)
        mapImage.pin.below(of: emailLine).marginTop(10).left(15).height(20).width(14)
        distriction.pin.below(of: emailLine).marginTop(10).left(40).height(20).right()
    }
}
