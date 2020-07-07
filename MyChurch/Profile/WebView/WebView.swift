//
//  WebView.swift
//  MyChurch
//
//  Created by Zhekon on 29.05.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class WebView: UIView {

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
      }
      
      override func layoutSubviews() {
          super.layoutSubviews()
      }
}
