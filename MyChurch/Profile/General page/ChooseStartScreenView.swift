//
//  ChooseStartScreenView.swift
//  MyChurch
//
//  Created by Zhekon on 29.04.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class ChooseStartScreenView: UIView {

    let startTableView = UITableView()
    
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
       
        addSubview(startTableView)
       }
       
       override func layoutSubviews() {
           super.layoutSubviews()
        startTableView.pin.all()
       }

}
