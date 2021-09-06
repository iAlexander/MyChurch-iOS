//
//  TechnicalSupportView.swift
//  MyChurch
//
//  Created by Taras Tanskiy on 14.07.2021.
//  Copyright © 2021 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

final class TechnicalSupportView: UIView {
   
    private let topTextLabel = UILabel()
    private let firstTextView = UITextView()
    private let secondTextView = UITextView()
    private let bottomText = UILabel()
    private let firstBullet = UILabel()
    private let secondBullet = UILabel()
    
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
        
        addSubview(topTextLabel)
        topTextLabel.text = "Зробимо разом наш застосунок кращим:"
        topTextLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        topTextLabel.textAlignment = .center
        topTextLabel.textColor = .black
        topTextLabel.numberOfLines = 0
        
        addSubview(firstTextView)
        firstTextView.translatesAutoresizingMaskIntoConstraints = true
        firstTextView.isScrollEnabled = false
        firstTextView.isUserInteractionEnabled = true
        firstTextView.isEditable = false
        firstTextView.isSelectable = true
        firstTextView.dataDetectorTypes = [.link]
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: "якщо у вас є зауваження чи побажання до наповнення, будь ласка, пишіть нам: ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular), .paragraphStyle: style]))
        attributedText.append(NSAttributedString(string: "support@pomisna.info", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular), .underlineStyle: NSUnderlineStyle.single.rawValue, .paragraphStyle: style]))

        firstTextView.attributedText = attributedText
        
        addSubview(secondTextView)
        secondTextView.translatesAutoresizingMaskIntoConstraints = true
        secondTextView.isScrollEnabled = false
        secondTextView.isUserInteractionEnabled = true
        secondTextView.isEditable = false
        secondTextView.isSelectable = true
        secondTextView.dataDetectorTypes = [.link]
        let secondAttributedText = NSMutableAttributedString()
        secondAttributedText.append(NSAttributedString(string: "якщо виникли технічні труднощі під час користування, будь ласка, звертайтеся до ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular), .paragraphStyle: style]))
        secondAttributedText.append(NSAttributedString(string: "support_cerkva@d2.digital", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular), .underlineStyle: NSUnderlineStyle.single.rawValue, .paragraphStyle: style]))
        let centerStyle = NSMutableParagraphStyle()
        centerStyle.alignment = NSTextAlignment.center
        secondAttributedText.append(NSAttributedString(string: "\n\n\nДякуємо!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular), .paragraphStyle: centerStyle]))
        secondTextView.attributedText = secondAttributedText
        
        addSubview(bottomText)
        bottomText.textColor = .lightGray
        bottomText.text = "Розробка застосунку - D2"
        bottomText.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        
        addSubview(firstBullet)
        firstBullet.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        firstBullet.textColor = UIColor.systemBlue
        firstBullet.text = "•"
        
        addSubview(secondBullet)
        secondBullet.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        secondBullet.textColor = UIColor.systemBlue
        secondBullet.text = "•"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topTextLabel.pin.top(70).horizontally(15).sizeToFit(.widthFlexible)
        firstTextView.pin.below(of: topTextLabel).marginTop(50).left(35).right(15).sizeToFit(.widthFlexible)
        firstBullet.pin.before(of: firstTextView, aligned: .top).left(15).marginTop(-4).sizeToFit()
        secondTextView.pin.below(of: firstTextView).marginTop(40).left(35).right(15).sizeToFit(.widthFlexible)
        secondBullet.pin.before(of: secondTextView, aligned: .top).left(15).marginTop(-4).sizeToFit()
        bottomText.pin.bottom(20).right(15).sizeToFit(.widthFlexible)
    }
}

