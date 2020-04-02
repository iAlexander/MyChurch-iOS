//
//  ChooseSanView.swift
//  MyChurch
//
//  Created by Zhekon on 31.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class ChooseSanView: UIView {
 
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
        topLabelText.text = "Оберiть сан"
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
