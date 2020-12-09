//
//  HistoryCell.swift
//  MyChurch
//
//  Created by Zhekon on 12.08.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    let statusImage = UIImageView()
    let date = UILabel()
    let cost = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(statusImage)
        statusImage.image = UIImage(named: "check")
        statusImage.contentMode = .scaleAspectFit
        
        addSubview(date)
        date.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        date.textAlignment = .left
        
        addSubview(cost)
        cost.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        cost.textAlignment = .left
        cost.textColor = UIColor(red: 0.529, green: 0.572, blue: 0.63, alpha: 1)
        cost.text = "111 грн"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        statusImage.pin.height(14).width(18).vCenter().left(20)
        date.pin.vCenter().left(to:statusImage.edge.right).marginLeft(15).height(28).width(200)
        cost.pin.vCenter().right(15).height(28).width(90)
    }
}
