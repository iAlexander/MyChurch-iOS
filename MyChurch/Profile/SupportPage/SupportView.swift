//
//  SupportView.swift
//  MyChurch
//
//  Created by Zhekon on 15.05.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class SupportView: UIView {
   
    let centreTextLabel = UILabel()
    let fbSupportButton = UIButton()
    private let fbButtonBlueLayer = CAGradientLayer()
    
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
        centreTextLabel.text = "Вітаємо! Це Ваш віртуальний помічник. Будь-ласка, поставте нам запитання."
        centreTextLabel.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        centreTextLabel.textAlignment = .center
        centreTextLabel.textColor = .black
        centreTextLabel.numberOfLines = 0
        
        fbButtonBlueLayer.colors = [
                 UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1).cgColor,
                 UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1).cgColor
             ]
             fbButtonBlueLayer.locations = [0, 1]
             fbButtonBlueLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
             fbButtonBlueLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
             fbButtonBlueLayer.cornerRadius = 10
             fbButtonBlueLayer.position = fbSupportButton.center
             fbSupportButton.layer.addSublayer(fbButtonBlueLayer)
             fbSupportButton.setTitle("Facebook", for: .normal)
             addSubview(fbSupportButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centreTextLabel.pin.top(50).horizontally(15).sizeToFit(.width)
        fbSupportButton.pin.below(of: centreTextLabel).marginTop(40).horizontally(15).height(40)
        fbButtonBlueLayer.pin.all()
    }
}
