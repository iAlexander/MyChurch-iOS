//
//  HramTableViewCell.swift
//  MyChurch
//
//  Created by Zhekon on 25.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class HramTableViewCell: UITableViewCell {
    
    let backView = UIView()
    let hramName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(white: 241.0 / 255.0, alpha: 1.0)
        
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 10
        addSubview(backView)
        
        backView.addSubview(hramName)
        hramName.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        hramName.textAlignment = .left
        hramName.textColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let widthScreen = UIScreen.main.bounds.width
        backView.pin.horizontally(5).vertically(4)
        hramName.pin.left(15).right().vertically(2)
    }
}
