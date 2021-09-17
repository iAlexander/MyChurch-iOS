//
//  DonateInformationView.swift
//  DonateInformationView
//
//  Created by Taras Tanskiy on 07.09.2021.
//  Copyright © 2021 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class DonateInformationView: UIView {
   
    let centreTextLabel = UILabel()
    let donateButton = UIButton()
    private let donateButtonBlueLayer = CAGradientLayer()
    
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
        
        addSubview(centreTextLabel)
        centreTextLabel.text = "Творімо добро разом:\nна благо людям і славу Божу!"
        centreTextLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        centreTextLabel.textAlignment = .center
        centreTextLabel.textColor = .black
        centreTextLabel.numberOfLines = 0
        
        donateButtonBlueLayer.colors = [
                 UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1).cgColor,
                 UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1).cgColor
             ]
        donateButtonBlueLayer.locations = [0, 1]
        donateButtonBlueLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        donateButtonBlueLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        donateButtonBlueLayer.cornerRadius = 10
        donateButtonBlueLayer.position = donateButton.center
        donateButton.layer.addSublayer(donateButtonBlueLayer)
        donateButton.setTitle("Благодійний внесок", for: .normal)
             addSubview(donateButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centreTextLabel.pin.top(50).horizontally(15).sizeToFit(.width)
        donateButton.pin.below(of: centreTextLabel).marginTop(40).horizontally(15).height(40)
        donateButtonBlueLayer.pin.all()
    }
}
