//
//  CalendarTableCell.swift
//  MyChurch
//
//  Created by Zhekon on 25.02.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class CalendarTableCell: UITableViewCell {
    
    private let falseBack = UIView()
    private let backWhite = UIView()
    private let goldenLine = UIView()
    private let layerGolden = CAGradientLayer()
    let holidayName = UILabel()
    let arrowImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        falseBack.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)//light gray
        falseBack.layer.masksToBounds = false
        falseBack.layer.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
        falseBack.layer.shadowOpacity = 1
        falseBack.layer.shadowOffset = CGSize(width: 1, height: 4)
        falseBack.layer.shadowRadius = 4
        falseBack.layer.cornerRadius = 8.0
        falseBack.isUserInteractionEnabled = false
        addSubview(falseBack)
        
        falseBack.addSubview(backWhite)
        backWhite.layer.cornerRadius = 8
        backWhite.backgroundColor = .white
        
        backWhite.addSubview(goldenLine)

        layerGolden.colors = [
          UIColor(red: 0.95, green: 0.745, blue: 0.218, alpha: 1).cgColor,
          UIColor(red: 0.938, green: 0.838, blue: 0.313, alpha: 1).cgColor
        ]
        layerGolden.locations = [0, 1]
        layerGolden.startPoint = CGPoint(x: 0.25, y: 0.5)
        layerGolden.endPoint = CGPoint(x: 0.75, y: 0.5)
        layerGolden.position = goldenLine.center
        goldenLine.layer.addSublayer(layerGolden)
        
        backWhite.addSubview(holidayName)
        holidayName.font = UIFont(name: "SFProText-Semibold", size: 13)
        holidayName.numberOfLines = 0
        holidayName.textAlignment = .left
        
        backWhite.addSubview(arrowImage)
        arrowImage.image = UIImage(named: "arrow")
        arrowImage.contentMode = .scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        falseBack.pin.horizontally().vertically(7.5)
        backWhite.pin.left().right(0.5).top().bottom(0.5)
        goldenLine.pin.left().vertically(5).width(2)
        layerGolden.pin.all()
        holidayName.pin.left(15).vertically(5).right(40)
        arrowImage.pin.right(15).vCenter().width(20).height(12)
    }
}
