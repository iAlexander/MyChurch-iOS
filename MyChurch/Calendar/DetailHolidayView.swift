//
//  DetailHolidayView.swift
//  MyChurch
//
//  Created by Zhekon on 26.02.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class DetailHolidayView: UIView {
    
    var imageCollectionView: UICollectionView!
    let goldenView = UIView()
    private let layerGolden = CAGradientLayer()
    let holidayTopName = UILabel()
    let holidayTopDate = UILabel()
    let holidayTopInfo = UILabel()
    let holidayTextView = UITextView()
    
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
        
        imageCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: imageLayout)
        imageCollectionView!.backgroundColor = .white
        addSubview(imageCollectionView!)
        
        addSubview(goldenView)
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
        goldenView.layer.addSublayer(layerGolden)
        
        addSubview(holidayTopName)
        holidayTopName.textAlignment = .left
        holidayTopName.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        addSubview(holidayTopDate)
        holidayTopDate.textAlignment = .left
        holidayTopDate.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        addSubview(holidayTopInfo)
        holidayTopInfo.textAlignment = .left
        holidayTopInfo.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        addSubview(holidayTextView)
        holidayTextView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageCollectionView.pin.top(20).left(5).height(240).right()
        goldenView.pin.below(of: imageCollectionView).marginTop(15).left(-22).width(35).height(80)
        layerGolden.pin.all()
        holidayTopName.pin.top(to:goldenView.edge.top).left(to:goldenView.edge.right).marginLeft(15).right().height(30)
        holidayTopDate.pin.below(of: holidayTopName).marginTop(5).left(to:goldenView.edge.right).marginLeft(15).right().height(20)
        holidayTopInfo.pin.below(of: holidayTopDate).marginTop(5).left(to:goldenView.edge.right).marginLeft(15).right().height(20)
        holidayTextView.pin.below(of: holidayTopInfo).marginTop(10).horizontally(15).bottom(100)
    }
}
