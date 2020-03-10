//
//  DetailMapView.swift
//  MyChurch
//
//  Created by Zhekon on 09.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class DetailMapView: UIView {
    
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
    private let templeHoliday = UILabel()
    private let fatherManName = UILabel()
    private let deanery = UILabel()
    private let telText = UILabel()
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
        
        churchTopName.textAlignment = .left
        churchTopName.numberOfLines = 0
        churchTopName.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        addSubview(churchTopName)
        
        eparhiyaCityName.textAlignment = .left
        eparhiyaCityName.numberOfLines = 0
        eparhiyaCityName.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        eparhiyaCityName.textColor = UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1)
        addSubview(eparhiyaCityName)
        
        openNow.textAlignment = .left
        openNow.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        openNow.text = "Зараз вiдчинено"
        openNow.textColor = UIColor(red: 0.153, green: 0.682, blue: 0.376, alpha: 1)
        addSubview(openNow)
        
        pointText.text = "•"
        pointText.textAlignment = .center
        pointText.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        addSubview(pointText)
        
        closeAtTop.textAlignment = .left
        closeAtTop.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        closeAtTop.text = "Зачиняється 20-00"
        closeAtTop.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        addSubview(closeAtTop)
        
        workScheduleText.textAlignment = .left
        workScheduleText.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        workScheduleText.text = "Розклад богослужіння"
        workScheduleText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        addSubview(workScheduleText)
        
        monFriday.textAlignment = .left
        monFriday.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        monFriday.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        addSubview(monFriday)
        
        markerImage.image = UIImage(named: "detailMarker")
        markerImage.contentMode = .scaleAspectFit
        addSubview(markerImage)
        
        adressText.textAlignment = .left
        adressText.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        adressText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        addSubview(adressText)
        
        self.addSubview(createRouteView)
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
        addSubview(templeHoliday)
        
        fatherManName.textAlignment = .left
        fatherManName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        fatherManName.text = "Настоятель:"
        fatherManName.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        addSubview(fatherManName)
        
        deanery.textAlignment = .left
        deanery.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        deanery.text = "Благочинний:"
        deanery.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        addSubview(deanery)
        
         telText.textAlignment = .left
         telText.font = UIFont.systemFont(ofSize: 18, weight: .bold)
         telText.text = "Телефон:"
         telText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
         addSubview(telText)
        
        templeHolidayApiText.textAlignment = .right
        templeHolidayApiText.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        templeHolidayApiText.text = "10 листопада"
        templeHolidayApiText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        addSubview(templeHolidayApiText)
        
        fatherManNameApiText.textAlignment = .right
        fatherManNameApiText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        fatherManNameApiText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        addSubview(fatherManNameApiText)
        
        deaneryApiText.textAlignment = .right
        deaneryApiText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        deaneryApiText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        addSubview(deaneryApiText)
        
        telApiText.textAlignment = .right
        telApiText.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        telApiText.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        addSubview(telApiText)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        churchTopName.pin.horizontally(15).top(20).height(50)
        eparhiyaCityName.pin.below(of: churchTopName).marginTop(20).horizontally(15).height(20)
        openNow.pin.left(15).below(of: eparhiyaCityName).marginTop(8).height(25).width((UIScreen.main.bounds.size.width / 2) - 40)
        pointText.pin.left(to:openNow.edge.right).top(to:openNow.edge.top).height(25).width(10)
        closeAtTop.pin.left(to:pointText.edge.right).top(to:pointText.edge.top).height(25).right().marginLeft(5)
        workScheduleText.pin.below(of: closeAtTop).marginTop(15).left(15).right().height(25)
        monFriday.pin.below(of: workScheduleText).horizontally(15).height(25)
        markerImage.pin.left(15).below(of: monFriday).marginTop(20).height(20).width(15)
        adressText.pin.top(to:markerImage.edge.top).bottom(to:markerImage.edge.bottom).left(to:markerImage.edge.right).marginLeft(15).right()
        createRouteView.pin.below(of: adressText).marginTop(25).horizontally(15).height(45)
        createRouteButton.pin.all()
        layerBlue.pin.all()
    
        templeHoliday.pin.below(of: createRouteView).marginTop(25).left(15).width(145).height(25)
        fatherManName.pin.below(of: templeHoliday).marginTop(5).left(15).width(115).height(25)
        deanery.pin.below(of: fatherManName).marginTop(5).left(15).width(125).height(25)
        telText.pin.below(of: deanery).marginTop(5).left(15).width(145).height(25)

        templeHolidayApiText.pin.right(15).top(to:templeHoliday.edge.top).left(to:templeHoliday.edge.right).height(25)
        fatherManNameApiText.pin.right(15).top(to:fatherManName.edge.top).left(to:fatherManName.edge.right).height(25)
        deaneryApiText.pin.right(15).top(to:deanery.edge.top).left(to:deanery.edge.right).height(25)
        telApiText.pin.right(15).top(to:telText.edge.top).left(to:telText.edge.right).height(25)
    }
}
