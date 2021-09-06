//
//  ChooseStatusView.swift
//  MyChurch
//
//  Created by Taras Tanskiy on 25.07.2021.
//  Copyright © 2021 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class ChooseStatusView: UIView {
 
    let topLabelText = UILabel()
    let sanTableView = UITableView()
    
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
        
        addSubview(topLabelText)
        topLabelText.text = "Оберiть статус"
        topLabelText.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        topLabelText.textAlignment = .left
        topLabelText.textColor = .black
        
        addSubview(sanTableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topLabelText.pin.top(20).horizontally(15).height(20)
        sanTableView.pin.below(of: topLabelText).marginTop(10).horizontally().bottom()
    }
}
