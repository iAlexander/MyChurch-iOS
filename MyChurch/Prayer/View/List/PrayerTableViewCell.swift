//
//  PrayerTableViewCell.swift
//  MyChurch
//
//  Created by Oleksandr Lohozinskyi on 02.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class PrayerTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = {
        return String(describing: self)
    }()
    
    var audioUrl: String?
    
    let elevatedView: UIView = {
        let view = UIView()
        view.elevate(cornerRadius: 8, elevation: 2)
        view.backgroundColor = .white
        
        return view
    }()
    
    let titleLabel = Label()
    let subtitleLabel = Label()
    let audioIndicator = UIButton()
    
    func configureWithData(title: String, text: String, audioUrl: String?) {
        self.selectionStyle = .none
        self.addSubview(self.elevatedView)
        self.elevatedView.addSubviews([self.titleLabel, self.subtitleLabel, self.audioIndicator])
        
        self.titleLabel.setValue(title, size: 16, fontWeight: .semibold, numberOfLines: 0)
        self.subtitleLabel.setValue(text, size: 12, lineHeight: 1.4, fontWeight: .regular, numberOfLines: 3, color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), lineBreakMode: .byTruncatingTail)
        if let url = audioUrl {
            //            let image = UIImage(named: "voice")
            //            self.audioIndicator.setImage(image, for: .normal)
            
            self.audioUrl = url
        }
        
        setupLayout()
    }
    
    private func setupLayout() {
        self.elevatedView.fillSuperview(padding: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16))
        self.titleLabel.anchor(top: self.elevatedView.topAnchor, leading: self.elevatedView.leadingAnchor, trailing: self.elevatedView.trailingAnchor, padding: UIEdgeInsets(top: 24, left: 16, bottom: 0, right: 16))
        self.subtitleLabel.anchor(top: self.titleLabel.bottomAnchor, leading: self.elevatedView.leadingAnchor, bottom: self.elevatedView.bottomAnchor, trailing: self.elevatedView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 16, bottom: 10, right: 16))
        self.audioIndicator.anchor(top: self.elevatedView.topAnchor, trailing: self.elevatedView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 16), size: CGSize(width: 16, height: 16))
    }
    
}

