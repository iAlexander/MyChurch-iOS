//
//  ChurchTableViewCell.swift
//  MyChurch
//
//  Created by Zhekon on 04.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class ChurchTableViewCell: UITableViewCell {

    let invitedLabel = UILabel()
    let searchIcon = UIImageView()
 //   var chooseRawAction: ((UITableViewCell) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        addSubview(invitedLabel)
        invitedLabel.font =  UIFont.systemFont(ofSize: 10, weight: .regular)
        invitedLabel.numberOfLines = 1
        invitedLabel.lineBreakMode = .byTruncatingTail
        
        addSubview(searchIcon)
        searchIcon.image = UIImage(named: "searchIcon")
        searchIcon.contentMode = .scaleAspectFit
      //  chooseButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }
    
//    @objc func buttonTap(sender: AnyObject) {
//        chooseRawAction?(self)
//    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchIcon.pin.left(10).height(17.5).width(17.5).vCenter()
        invitedLabel.pin.left(32.5).vCenter().maxWidth(self.frame.width - 33).sizeToFit()
    }
}
