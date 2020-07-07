//
//  NotificationCell.swift
//  MyChurch
//
//  Created by Zhekon on 26.05.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    let notificationImage = UIImageView()
    let notificationText = UILabel()
    let dataText = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        addSubview(notificationText)
        notificationText.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        notificationText.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        notificationText.numberOfLines = 0
        notificationText.lineBreakMode = .byWordWrapping
        
        addSubview(notificationImage)
        notificationImage.image = UIImage(named: "notificationPoint")
        notificationImage.contentMode = .scaleAspectFit
        
        addSubview(dataText)
        dataText.textColor = UIColor(red: 0.484, green: 0.49, blue: 0.5, alpha: 1)
        dataText.font = UIFont(name: "SFProText-Regular", size: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        notificationText.pin.bottom(15).left(30).height(45).right(15)
        notificationImage.pin.top(20).left(15).width(10).height(10)
        dataText.pin.top(15).horizontally(30).height(20)
    }
}
