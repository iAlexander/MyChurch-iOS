//
//  DetailHolidayView.swift
//  MyChurch
//
//  Created by Zhekon on 26.02.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class DetailHolidayView: UIView {
    
    var scroll = UIScrollView()
    var imageView = UIImageView()
    let goldenView = UIView()
    private let layerGolden = CAGradientLayer()
    let holidayTopName = UILabel()
    let holidayTopDate = UILabel()
    let holidayTopInfo = UILabel()
    let holidayTextLabel = UILabel()
    var imageIsEmpty = true
    
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
        
        let imageLayout = UICollectionViewFlowLayout.init()
        imageLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        imageLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        imageLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60, height: 240)
        
        addSubview(scroll)
        
        scroll.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        
        scroll.addSubview(goldenView)
        layerGolden.colors = [
            UIColor(red: 0.95, green: 0.745, blue: 0.218, alpha: 1).cgColor,
            UIColor(red: 0.938, green: 0.838, blue: 0.313, alpha: 1).cgColor
        ]
        layerGolden.locations = [0, 1]
        layerGolden.startPoint = CGPoint(x: 0.5, y: 0.25)
        layerGolden.endPoint = CGPoint(x: 0.5, y: 0.75)
        layerGolden.cornerRadius = 5
        layerGolden.position = goldenView.center
        goldenView.layer.cornerRadius = 5
      //  goldenView.layer.addSublayer(layerGolden)
        
        scroll.addSubview(holidayTopName)
        holidayTopName.textAlignment = .left
        holidayTopName.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        holidayTopName.numberOfLines = 0
        
        scroll.addSubview(holidayTopDate)
        holidayTopDate.textAlignment = .left
        holidayTopDate.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        scroll.addSubview(holidayTopInfo)
        holidayTopInfo.textAlignment = .left
        holidayTopInfo.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        holidayTopInfo.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        scroll.addSubview(holidayTextLabel)
        holidayTextLabel.numberOfLines = 0
        holidayTextLabel.lineBreakMode = .byWordWrapping
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scroll.pin.all()
        if !imageIsEmpty {
            imageView.pin.top(20).left(15).height(240).right(15)
            goldenView.pin.below(of: imageView).marginTop(15).left(-20).width(35)
        } else {
            goldenView.pin.top(20).left(-20).width(35)
        }
        layerGolden.pin.all()
        holidayTopName.pin.top(to:goldenView.edge.top).left(to:goldenView.edge.right).marginLeft(15).right(15).sizeToFit(.widthFlexible)
        holidayTopDate.pin.below(of: holidayTopName).marginTop(5).left(to:goldenView.edge.right).marginLeft(15).right().height(20)
        holidayTopInfo.pin.below(of: holidayTopDate).marginTop(5).left(to:goldenView.edge.right).marginLeft(15).right().height(20)
        holidayTextLabel.numberOfLines = 0
        holidayTextLabel.pin.below(of: holidayTopInfo).marginTop(10).horizontally(15).sizeToFit(.widthFlexible)
        let goldenViewHeight = holidayTopName.frame.size.height + holidayTopDate.frame.size.height + holidayTopInfo.frame.size.height + 10
        goldenView.pin.height(goldenViewHeight)
        scroll.contentSize = CGSize(width: self.frame.size.width, height: holidayTextLabel.frame.maxY + 15)
    }
}
