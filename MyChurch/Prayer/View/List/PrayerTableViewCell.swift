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
    
    let elevatedView: UIView = {
        let view = UIView()
        view.elevate(cornerRadius: 8, elevation: 2)
        view.backgroundColor = .white
        
        return view
    }()
    
    let titleLabel = Label()
    let subtitleLabel = Label()
    
    func configureWithData(title: String, text: String) {
        self.selectionStyle = .none
        self.addSubview(self.elevatedView)
        self.elevatedView.addSubviews([self.titleLabel, self.subtitleLabel])
        
        self.titleLabel.setValue(title, size: 16, fontWeight: .semibold, numberOfLines: 0)
        self.subtitleLabel.setValue(text, size: 12, fontWeight: .regular, numberOfLines: 3, color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1))
        
        setupLayout()
    }
    
    private func setupLayout() {
        self.elevatedView.fillSuperview(padding: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16))
        self.titleLabel.anchor(top: self.elevatedView.topAnchor, leading: self.elevatedView.leadingAnchor, trailing: self.elevatedView.trailingAnchor, padding: UIEdgeInsets(top: 24, left: 16, bottom: 0, right: 16))
        self.subtitleLabel.anchor(top: self.titleLabel.bottomAnchor, leading: self.elevatedView.leadingAnchor, bottom: self.elevatedView.bottomAnchor, trailing: self.elevatedView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 16, bottom: 24, right: 16))
    }

}
