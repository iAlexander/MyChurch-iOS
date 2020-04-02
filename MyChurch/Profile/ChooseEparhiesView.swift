//
//  ChooseEparhiesView.swift
//  MyChurch
//
//  Created by Zhekon on 26.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class ChooseEparhiesView: UIView {
    
    let topLabelText = UILabel()
    let hramTableView = UITableView()
    
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
        topLabelText.text = "Оберiть єпархiю"
        topLabelText.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        topLabelText.textAlignment = .left
        topLabelText.textColor = .black
        
        addSubview(hramTableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topLabelText.pin.top(75).horizontally(30).height(20)
        hramTableView.pin.below(of: topLabelText).marginTop(10).horizontally().bottom()
    }
}
