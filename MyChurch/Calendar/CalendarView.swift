//
//  CalendarView.swift
//  MyChurch
//
//  Created by Zhekon on 24.02.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit
import Koyomi
import PinLayout


class CalendarView: UIView {
    
    var calendar = Koyomi(frame: CGRect(), sectionSpace: 10, cellSpace: 5.5, inset: .zero, weekCellHeight: 25)
    var choosedDay = UILabel()
    let holidayTableView = UITableView()

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
        
        addSubview(calendar)
        calendar.weeks = ("Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс")
        calendar.style = .standard
        calendar.selectedStyleColor = UIColor(red: 60.0 / 255.0, green: 121.0 / 255.0, blue: 186.0 / 255.0, alpha: 1.0)
    
        // private let layerBlue = CAGradientLayer()
//        layerBlue.colors = [
//               UIColor(red: 0.004, green: 0.478, blue: 0.898, alpha: 1).cgColor,
//                 UIColor(red: 0.004, green: 0.773, blue: 0.988, alpha: 1).cgColor
//               ]
//               layerBlue.locations = [0, 1]
//               layerBlue.startPoint = CGPoint(x: 0.25, y: 0.5)
//               layerBlue.endPoint = CGPoint(x: 0.75, y: 0.5)
//               layerBlue.position = calendar.center
//               calendar.layer.addSublayer(layerBlue)

        calendar.selectionMode = .single(style: .circle)
        calendar.dayPosition = .center
        calendar.weekColor = .black
        calendar.separatorColor = .white
        calendar.sectionSeparatorColor = .white
        calendar.weekdayColor = .black
        calendar.holidayColor = (.lightGray, .lightGray)
        calendar.isHiddenOtherMonth = true
        calendar
            .setDayFont(fontName: "SF Pro Text", size: 14)
            .setWeekFont(fontName: "SF Pro Text", size: 14)
        
        addSubview(choosedDay)
        choosedDay.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        choosedDay.textAlignment = .left
        
        addSubview(holidayTableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calendar.pin.horizontally(10).top(25).height(270)
        choosedDay.pin.below(of: calendar).marginTop(35).left(20).width(200).height(25)
        holidayTableView.pin.below(of: choosedDay).marginTop(15).horizontally(15).bottom()
    }
}
