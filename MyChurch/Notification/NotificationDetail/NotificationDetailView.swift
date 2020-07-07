//
//  NotificationDetailView.swift
//  MyChurch
//
//  Created by Zhekon on 28.05.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class NotificationDetailView: UIView {
    
    let date = UILabel()
    let textNotification = UITextView()
    
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
        
        addSubview(date)
        date.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        date.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        addSubview(textNotification)
        textNotification.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        textNotification.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        date.pin.top(25).horizontally(15).height(20)
        textNotification.pin.below(of: date).horizontally(15).bottom()
    }
}
