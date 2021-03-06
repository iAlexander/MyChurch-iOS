//
//  RegistrationSecondPageView.swift
//  MyChurch
//
//  Created by Zhekon on 19.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class RegistrationSecondPageView: UIView {
    
    let arhieriyButton = UIButton()
    private let layerBlue = CAGradientLayer()
    let clergyButton = UIButton()
    private let layerBlueSecond = CAGradientLayer()
    let believerButton = UIButton()
    private let layerBlueThird = CAGradientLayer()
     
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
        layerBlue.position = arhieriyButton.center
        arhieriyButton.layer.addSublayer(layerBlue)
        arhieriyButton.setTitle("Архієрей", for: .normal)
        addSubview(arhieriyButton)
        
        layerBlueSecond.colors = [
            UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1).cgColor,
            UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1).cgColor
        ]
        layerBlueSecond.locations = [0, 1]
        layerBlueSecond.startPoint = CGPoint(x: 0.25, y: 0.5)
        layerBlueSecond.endPoint = CGPoint(x: 0.75, y: 0.5)
        layerBlueSecond.cornerRadius = 10
        layerBlueSecond.position = clergyButton.center
        clergyButton.layer.addSublayer(layerBlueSecond)
        clergyButton.setTitle("Духовенство", for: .normal)
        addSubview(clergyButton)
        
        layerBlueThird.colors = [
            UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1).cgColor,
            UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1).cgColor
        ]
        layerBlueThird.locations = [0, 1]
        layerBlueThird.startPoint = CGPoint(x: 0.25, y: 0.5)
        layerBlueThird.endPoint = CGPoint(x: 0.75, y: 0.5)
        layerBlueThird.cornerRadius = 10
        layerBlueThird.position = believerButton.center
        believerButton.layer.addSublayer(layerBlueThird)
        believerButton.setTitle("Вірянин", for: .normal)
        addSubview(believerButton)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        arhieriyButton.pin.vCenter(-40).horizontally(15).height(40)
        layerBlue.pin.all()
        clergyButton.pin.above(of: arhieriyButton).horizontally(15).marginBottom(15).height(40)
        layerBlueSecond.pin.all()
        believerButton.pin.above(of: clergyButton).horizontally(15).marginBottom(15).height(40)
        layerBlueThird.pin.all()
    }
    
}
