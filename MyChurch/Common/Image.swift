//
//  Image.swift
//  PCU
//
//  Created by Oleksandr Lohozinskyi on 23.01.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    
    convenience init(contentMode: ContentMode = .scaleAspectFill, cornerRadius: CGFloat) {
        self.init()
        
        self.clipsToBounds = true
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
    }
    
//    override var intrinsicContentSize: CGSize {
//        if let myImage = self.image {
//            let myImageWidth = myImage.size.width
//            let myImageHeight = myImage.size.height
//            let myViewWidth = self.frame.size.width
//            
//            let ratio = myViewWidth / myImageWidth
//            let scaledHeight = myImageHeight * ratio
//            
//            return CGSize(width: myViewWidth, height: scaledHeight)
//        }
//        
//        return CGSize(width: -1.0, height: -1.0)
//    }
    
    func squaredRatio(width: CGFloat, height: CGFloat) {
        if width > height {
//            self.intrinsicContentSize = CGSize(width: height, height: height)
            
        } else {
            
        }
    }
    
}
