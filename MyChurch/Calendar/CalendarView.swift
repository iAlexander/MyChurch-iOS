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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calendar.pin.horizontally(10).top(25).height(270)
        choosedDay.pin.below(of: calendar).marginTop(35).left(20).width(200).height(25)
    }

}
