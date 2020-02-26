//
//  Button.swift
//  MyChurch
//
//  Created by Oleksandr Lohozinskyi on 25.02.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    required init(_ title: String, fontSize: CGFloat = 17, fontColor: UIColor = .white, fontWeight: UIFont.Weight = .regular) {
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.fontWeight = fontWeight
        
        super.init(frame: .zero)
        setAttributedText(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let custom = NSAttributedString.Key.self
    
    var fontColor: UIColor!
    var fontSize: CGFloat!
    var fontWeight: UIFont.Weight!
    
    func setAttributedText(_ string: String?) {
        let string: String = string != nil ? string! : ""
        
        self.setAttributedTitle(NSMutableAttributedString(string: string, attributes: [self.custom.foregroundColor: self.fontColor, custom.font: UIFont.systemFont(ofSize: self.fontSize, weight: self.fontWeight)]), for: .normal)
    }
    
}

class GradientButton: UIButton {
    
    required init(_ title: String, fontSize: CGFloat = 17, fontColor: UIColor = .white, fontWeight: UIFont.Weight = .regular, gradientColors: [UIColor], startPoint: CGPoint = CGPoint(x: 0, y: 0.5), endPoint: CGPoint = CGPoint(x: 1, y: 0.5)) {
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.fontWeight = fontWeight
        self.gradientColors = gradientColors
        self.startPoint = startPoint
        self.endPoint = endPoint
        
        super.init(frame: .zero)
        setAttributedText(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let custom = NSAttributedString.Key.self
    
    var fontColor: UIColor!
    var fontSize: CGFloat!
    var fontWeight: UIFont.Weight!
    
    let gradientColors : [UIColor]
    let startPoint : CGPoint
    let endPoint : CGPoint
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let halfOfButtonHeight = layer.frame.height / 2
        contentEdgeInsets = UIEdgeInsets(top: 10, left: halfOfButtonHeight, bottom: 10, right: halfOfButtonHeight)
        
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        backgroundColor = UIColor.clear
        
        // setup gradient
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = gradientColors.map { $0.cgColor }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.cornerRadius = 8
        
        // replace gradient as needed
        if let oldGradient = layer.sublayers?[0] as? CAGradientLayer {
            layer.replaceSublayer(oldGradient, with: gradient)
        } else {
            layer.insertSublayer(gradient, below: nil)
        }
        
        // setup shadow
        
//        layer.shadowColor = UIColor.darkGray.cgColor
//        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: halfOfButtonHeight).cgPath
//        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        layer.shadowOpacity = 0.85
//        layer.shadowRadius = 4.0
    }
    
    override var isHighlighted: Bool {
        didSet {
            let newOpacity : Float = isHighlighted ? 0.1 : 0.15
            let newRadius : CGFloat = isHighlighted ? 12.0 : 8.0
            
            let shadowOpacityAnimation = CABasicAnimation()
            shadowOpacityAnimation.keyPath = "shadowOpacity"
            shadowOpacityAnimation.fromValue = layer.shadowOpacity
            shadowOpacityAnimation.toValue = newOpacity
            shadowOpacityAnimation.duration = 0.1
            
            let shadowRadiusAnimation = CABasicAnimation()
            shadowRadiusAnimation.keyPath = "shadowRadius"
            shadowRadiusAnimation.fromValue = layer.shadowRadius
            shadowRadiusAnimation.toValue = newRadius
            shadowRadiusAnimation.duration = 0.1
            
            layer.add(shadowOpacityAnimation, forKey: "shadowOpacity")
            layer.add(shadowRadiusAnimation, forKey: "shadowRadius")
            
            layer.shadowOpacity = newOpacity
            layer.shadowRadius = newRadius
            
            let xScale : CGFloat = isHighlighted ? 1.025 : 1.0
            let yScale : CGFloat = isHighlighted ? 1.05 : 1.0
            UIView.animate(withDuration: 0.1) {
                let transformation = CGAffineTransform(scaleX: xScale, y: yScale)
                self.transform = transformation
            }
        }
    }
    
    func setAttributedText(_ string: String?) {
        let string: String = string != nil ? string! : ""
        
        self.setAttributedTitle(NSMutableAttributedString(string: string, attributes: [self.custom.foregroundColor: self.fontColor, custom.font: UIFont.systemFont(ofSize: self.fontSize, weight: self.fontWeight)]), for: .normal)
    }
    
}
