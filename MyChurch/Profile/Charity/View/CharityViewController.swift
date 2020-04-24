//
//  CharityViewController.swift
//  MyChurch
//
//  Created by Oleksandr Lohozinskyi on 30.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class CharityViewController: ViewController {
    
    let titleLabel: Label = {
        let label = Label("Пожертвувати кошти через", size: 16, fontWeight: .bold, numberOfLines: 0, color: .black, textAlignment: .center)
        
        return label
    }()
    
    let descriptionLabel: Label = {
        let label = Label("Не обов'язково чекати свята Миколая, щоб зробити добру справу. Адже, тільки справжня добра справа йде від серця, і тільки вона може подарувати щастя.", size: 16, fontWeight: .regular, numberOfLines: 0, color: .black, textAlignment: .center)
        
        return label
    }()
    
    let pbButton: GradientButton = {
        let button = GradientButton("Privat24", fontSize: 18, fontColor: .white, fontWeight: .semibold, gradientColors: [UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1), UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1)])
        button.tag = 1
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        
        return button
    }()
    let portmoneButton: GradientButton = {
        let button = GradientButton("Portmone", fontSize: 18, fontColor: .white, fontWeight: .semibold, gradientColors: [UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1), UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1)])
        button.tag = 2
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        
        return button
    }()
    let paypalButton: GradientButton = {
        let button = GradientButton("PayPal", fontSize: 18, fontColor: .white, fontWeight: .semibold, gradientColors: [UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1), UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1)])
        button.tag = 3
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubviews([self.titleLabel, self.descriptionLabel, self.pbButton, self.portmoneButton, self.paypalButton])
        
        setupNavBar()
        setupLayout()
    }
    
    private func setupNavBar() {
        self.navigationItem.leftBarButtonItems = [backBarButtonItem]
        self.navigationItem.rightBarButtonItems = [notificationhBarButtonItem]
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Благодійність"
        
        super.backBarButtonItem.action = #selector(dismissViewController)
        super.notificationhBarButtonItem.action = #selector(openNotification)
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .white
        
        self.titleLabel.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 36, left: 16, bottom: 0, right: 16))
        
        self.descriptionLabel.anchor(top: self.titleLabel.bottomAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 26, left: 16, bottom: 0, right: 16))
        
        self.pbButton.anchor(top: self.descriptionLabel.bottomAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 36, left: 16, bottom: 0, right: 16))
        self.portmoneButton.anchor(top: self.pbButton.bottomAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        self.paypalButton.anchor(top: self.portmoneButton.bottomAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
    }

}

extension CharityViewController {
    
    @objc func pay(_ sender: UIButton!) {
        print("sender tag = \(sender.tag)")
    }
    
    @objc func dismissViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func openNotification(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
