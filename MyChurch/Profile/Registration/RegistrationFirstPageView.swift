//
//  ProfileView.swift
//  MyChurch
//
//  Created by Zhekon on 19.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class RegistrationFirstPageView: UIView {
    
    let charityButton = UIButton()
    private let layerBlue = CAGradientLayer()
    let spiritualSupportButton = UIButton()
    private let layerBlueSecond = CAGradientLayer()
    let personalAreaButton = UIButton()
    private let layerBlueThird = CAGradientLayer()
    let technicalSupportButton = UIButton()
    private let layerBlueFourth = CAGradientLayer()
    
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
        
        layerBlue.colors = [
            UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1).cgColor,
            UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1).cgColor
        ]
        layerBlue.locations = [0, 1]
        layerBlue.startPoint = CGPoint(x: 0.25, y: 0.5)
        layerBlue.endPoint = CGPoint(x: 0.75, y: 0.5)
        layerBlue.cornerRadius = 10
        layerBlue.position = charityButton.center
        charityButton.layer.addSublayer(layerBlue)
        charityButton.setTitle("Благодiйнiсть", for: .normal)
        addSubview(charityButton)
        
        layerBlueSecond.colors = [
            UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1).cgColor,
            UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1).cgColor
        ]
        layerBlueSecond.locations = [0, 1]
        layerBlueSecond.startPoint = CGPoint(x: 0.25, y: 0.5)
        layerBlueSecond.endPoint = CGPoint(x: 0.75, y: 0.5)
        layerBlueSecond.cornerRadius = 10
        layerBlueSecond.position = spiritualSupportButton.center
        spiritualSupportButton.layer.addSublayer(layerBlueSecond)
        spiritualSupportButton.setTitle("Духовна підтримка", for: .normal)
        addSubview(spiritualSupportButton)
        
        layerBlueThird.colors = [
            UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1).cgColor,
            UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1).cgColor
        ]
        layerBlueThird.locations = [0, 1]
        layerBlueThird.startPoint = CGPoint(x: 0.25, y: 0.5)
        layerBlueThird.endPoint = CGPoint(x: 0.75, y: 0.5)
        layerBlueThird.cornerRadius = 10
        layerBlueThird.position = personalAreaButton.center
        personalAreaButton.layer.addSublayer(layerBlueThird)
        addSubview(personalAreaButton)
        
        layerBlueFourth.colors = [
            UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1).cgColor,
            UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1).cgColor
        ]
        layerBlueFourth.locations = [0, 1]
        layerBlueFourth.startPoint = CGPoint(x: 0.25, y: 0.5)
        layerBlueFourth.endPoint = CGPoint(x: 0.75, y: 0.5)
        layerBlueFourth.cornerRadius = 10
        layerBlueFourth.position = technicalSupportButton.center
        technicalSupportButton.layer.addSublayer(layerBlueFourth)
        technicalSupportButton.setTitle("Зворотний зв’язок", for: .normal)
        addSubview(technicalSupportButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        charityButton.pin.vCenter(-40).horizontally(15).height(40)
        layerBlue.pin.all()
        spiritualSupportButton.pin.above(of: charityButton).horizontally(15).marginBottom(15).height(40)
        layerBlueSecond.pin.all()
        personalAreaButton.pin.above(of: spiritualSupportButton).horizontally(15).marginBottom(15).height(40)
        layerBlueThird.pin.all()
        technicalSupportButton.pin.below(of: charityButton).horizontally(15).marginTop(15).height(40)
        layerBlueFourth.pin.all()
    }
}
