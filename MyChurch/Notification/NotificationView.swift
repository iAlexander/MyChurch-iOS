//
//  NotificationView.swift
//  MyChurch
//
//  Created by Zhekon on 26.05.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class NotificationView: UIView {
    
    let notificationTableView = UITableView()
    
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
        addSubview(notificationTableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var bottomPadding: CGFloat = 0.0
                if #available(iOS 11.0, *) {
                    let window = UIApplication.shared.keyWindow
                    bottomPadding = window?.safeAreaInsets.bottom ?? 0.0
                    if bottomPadding > 0.0 {
                        bottomPadding = 58.0
                    }
                }
        notificationTableView.pin.top().horizontally().bottom(bottomPadding)
    }
}
