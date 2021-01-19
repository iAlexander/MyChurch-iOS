//
//  NoInternetAlert.swift
//  MyChurch
//
//  Created by Тарас on 15.12.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

final class NoInternetAlert: UIViewController {
    
    private var wifiImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "no-signal")
        return imageView
    }()
    private let alertView = UIView()
    private let topLabel = Label("Проблеми з’єднання", size: 18, fontWeight: .bold, numberOfLines: 0, textAlignment: .center)
    private let textLabel = Label("Перевірте підключення до інтернету", size: 14, numberOfLines: 0, textAlignment: .center)
    private let button: GradientButton = {
        let button = GradientButton("ОК", fontSize: 18, fontColor: .white, fontWeight: .semibold, gradientColors: [UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1), UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1)])
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(true, forKey: "NoInternetAlertWasPresented")
        self.view.addSubview(self.alertView)
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.alertView.backgroundColor = .white
        self.alertView.elevate(cornerRadius: 8, elevation: 2)
        self.alertView.addSubviews([self.wifiImageView, self.topLabel, self.textLabel, self.button])
        setupLayout()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        self.alertView.anchor(centerY: self.view.centerYAnchor, centerX: self.view.centerXAnchor)
        self.alertView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        self.alertView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        self.wifiImageView.pin.top(20).hCenter().width(128).height(128)
        self.topLabel.pin.below(of: wifiImageView).marginTop(10).horizontally(15).sizeToFit(.width)
        self.textLabel.pin.below(of: topLabel).marginTop(10).horizontally(15).sizeToFit(.width)
        self.button.pin.bottom(15).horizontally(15).height(40)
    }
    
    @objc private func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
