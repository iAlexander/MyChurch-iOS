//
//  DetailMapView.swift
//  MyChurch
//
//  Created by Zhekon on 09.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class DetailMapView: UIView {
    
    let scrollView = UIScrollView()
    let churchTopName = UILabel()
    let eparhiyaCityName = UILabel()
    let openNow = UILabel()
    let pointText = UILabel()
    let closeAtTop = UILabel()
    let workScheduleText = UILabel()
    let monFriday = UILabel()
    let markerImage = UIImageView()
    let adressText = UILabel()
    let createRouteView = UIView()
    private let layerBlue = CAGradientLayer()
    let createRouteButton = UIButton()
    let templeHoliday = UILabel()
    let fatherManName = UILabel()
    let deanery = UILabel()
    let telText = UILabel()
    let templeHolidayApiText = UILabel()
    let fatherManNameApiText = UILabel()
    let deaneryApiText = UILabel()
    let telApiText = UILabel()
    
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
        
        self.addSubview(scrollView)
        scrollView.backgroundColor = .clear
        scrollView.alpha = 0
        
        churchTopName.textAlignment = .left
        churchTopName.numberOfLines = 0
        churchTopName.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        scrollView.addSubview(churchTopName)
        
        eparhiyaCityName.textAlignment = .left
        eparhiyaCityName.numberOfLines = 0
        eparhiyaCityName.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        eparhiyaCityName.textColor = UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1)
        scrollView.addSubview(eparhiyaCityName)
        
        openNow.textAlignment = .left
        openNow.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        openNow.text = "Зараз вiдчинено"
        openNow.textColor = UIColor(red: 0.153, green: 0.682, blue: 0.376, alpha: 1)
        scrollView.addSubview(openNow)
        
        pointText.text = "•"
        pointText.textAlignment = .center
        pointText.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        scrollView.addSubview(pointText)
        
        closeAtTop.textAlignment = .left
        closeAtTop.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        closeAtTop.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        scrollView.addSubview(closeAtTop)
        
        workScheduleText.textAlignment = .left
        workScheduleText.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        workScheduleText.text = "Розклад богослужіння"
        workScheduleText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        scrollView.addSubview(workScheduleText)
        
        monFriday.textAlignment = .left
        monFriday.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        monFriday.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        monFriday.adjustsFontSizeToFitWidth = true
        scrollView.addSubview(monFriday)
        
        markerImage.image = UIImage(named: "detailMarker")
        markerImage.contentMode = .scaleAspectFit
        scrollView.addSubview(markerImage)
        
        adressText.textAlignment = .left
        adressText.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        adressText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        adressText.numberOfLines = 0
        adressText.adjustsFontSizeToFitWidth = true
        scrollView.addSubview(adressText)
        
        scrollView.addSubview(createRouteView)
        createRouteView.layer.cornerRadius = 10
        layerBlue.colors = [
            UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1).cgColor,
            UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1).cgColor
        ]
        layerBlue.locations = [0, 1]
        layerBlue.startPoint = CGPoint(x: 0.25, y: 0.5)
        layerBlue.endPoint = CGPoint(x: 0.75, y: 0.5)
        layerBlue.cornerRadius = 10
        layerBlue.position = createRouteView.center
        createRouteView.layer.addSublayer(layerBlue)
        
        createRouteView.addSubview(createRouteButton)
        createRouteButton.setTitle("Прокласти маршрут", for: .normal)
        createRouteButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        templeHoliday.textAlignment = .left
        templeHoliday.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        templeHoliday.text = "Храмове свято:"
        templeHoliday.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        scrollView.addSubview(templeHoliday)
        
        fatherManName.textAlignment = .left
        fatherManName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        fatherManName.text = "Настоятель:"
        fatherManName.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        scrollView.addSubview(fatherManName)
        
        deanery.textAlignment = .left
        deanery.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        deanery.text = "Благочинний:"
        deanery.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        scrollView.addSubview(deanery)
        
        telText.textAlignment = .left
        telText.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        telText.text = "Телефон:"
        telText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        scrollView.addSubview(telText)
        
        templeHolidayApiText.textAlignment = .right
        templeHolidayApiText.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        templeHolidayApiText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        templeHolidayApiText.numberOfLines = 0
        scrollView.addSubview(templeHolidayApiText)
        
        fatherManNameApiText.textAlignment = .right
        fatherManNameApiText.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        fatherManNameApiText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        fatherManNameApiText.numberOfLines = 0
        scrollView.addSubview(fatherManNameApiText)
        
        deaneryApiText.textAlignment = .right
        deaneryApiText.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        deaneryApiText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        deaneryApiText.numberOfLines = 0
        scrollView.addSubview(deaneryApiText)
        
        telApiText.textAlignment = .right
        telApiText.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        telApiText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        telApiText.numberOfLines = 0
        scrollView.addSubview(telApiText)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.pin.all()
        churchTopName.pin.top(20).horizontally(15).sizeToFit(.widthFlexible)
        eparhiyaCityName.pin.below(of: churchTopName).marginTop(20).horizontally(15).sizeToFit(.widthFlexible)
        
        //        openNow.pin.left(15).below(of: eparhiyaCityName).marginTop(8).height(25).width((UIScreen.main.bounds.size.width / 2) - 40)
        //        pointText.pin.left(to:openNow.edge.right).top(to:openNow.edge.top).height(25).width(10)
        //        closeAtTop.pin.left(to:pointText.edge.right).top(to:pointText.edge.top).height(25).right().marginLeft(5)
        
        workScheduleText.pin.below(of: eparhiyaCityName).marginTop(5).left(15).right().height(25)
        monFriday.pin.below(of: workScheduleText).horizontally(15).sizeToFit(.widthFlexible)
        markerImage.pin.left(15).below(of: monFriday).marginTop(15).height(20).width(15)
        adressText.pin.right(of: markerImage, aligned: .center).marginLeft(13).right(15).sizeToFit(.widthFlexible)
        createRouteView.pin.below(of: adressText).marginTop(25).horizontally(15).height(45)
        createRouteButton.pin.all()
        layerBlue.pin.all()        
        
        templeHoliday.pin.below(of: createRouteView).marginTop(25).left(15).sizeToFit(.widthFlexible)
        templeHolidayApiText.pin.below(of: createRouteView).marginTop(25).after(of: templeHoliday).marginLeft(15).right(15).sizeToFit(.width)
        fatherManName.pin.below(of: templeHolidayApiText).marginTop(10).left(15).sizeToFit(.widthFlexible)
        fatherManNameApiText.pin.below(of: templeHolidayApiText).marginTop(10).after(of: fatherManName).marginLeft(15).right(15).sizeToFit(.width)
        deanery.pin.below(of: fatherManNameApiText.frame.height == 0 ? templeHolidayApiText : fatherManNameApiText).marginTop(10).left(15).sizeToFit(.widthFlexible)
        deaneryApiText.pin.below(of: fatherManNameApiText.frame.height == 0 ? templeHolidayApiText : fatherManNameApiText).marginTop(10).after(of: fatherManName).marginLeft(15).right(15).sizeToFit(.width)
        telText.pin.below(of: deaneryApiText.frame.height == 0 ? fatherManNameApiText : deaneryApiText).marginTop(10).left(15).sizeToFit(.widthFlexible)
        telApiText.pin.below(of: deaneryApiText.frame.height == 0 ? fatherManNameApiText : deaneryApiText).marginTop(10).after(of: fatherManName).marginLeft(15).right(15).sizeToFit(.width)
        scrollView.contentSize = CGSize(width:  UIScreen.main.bounds.size.width, height: telApiText.frame.maxY + 15)
    }
}
//
//        openNow.pin.left(15).below(of: eparhiyaCityName).marginTop(8).height(25).width((UIScreen.main.bounds.size.width / 2) - 40)
//        pointText.pin.left(to:openNow.edge.right).top(to:openNow.edge.top).height(25).width(10)
//        closeAtTop.pin.left(to:pointText.edge.right).top(to:pointText.edge.top).height(25).right().marginLeft(5)
