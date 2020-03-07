//
//  ModalViewController.swift
//  MyChurch
//
//  Created by Oleksandr Lohozinskyi on 07.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

protocol ModalDelegate: class {
    func dismiss()
}

class ModalViewController: UIViewController {
    
    convenience init(delegate: ModalDelegate) {
        self.init()
        
        self.delegate = delegate
    }
    
    weak var delegate: ModalDelegate?
    
    var isActive = true {
        willSet {
            self.button.isEnabled = newValue
            self.button.alpha = newValue ? 1 : 0.25
            
            self.checkbox.setImage(newValue ? self.checkOn : self.checkOff, for: .normal)
        }
    }
    
    let checkOn = UIImage(named: "checkbox-on")
    let checkOff = UIImage(named: "checkbox-off")
    
    let alertView = UIView()
    lazy var checkbox: UIButton = {
        let button = UIButton()
        button.setImage(self.checkOn, for: .normal)
        button.addTarget(self, action: #selector(activate), for: .touchUpInside)
        
        return button
    }()
    let textLabel = Label("Даю згоду на обробку даних згідно", size: 14, numberOfLines: 2)
    let linkButton: UIButton = {
        let button = UIButton()
        let custom = NSAttributedString.Key.self
        let attributedText = NSMutableAttributedString(string: "Політики конфіденційності", attributes: [custom.foregroundColor: UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1), custom.font: UIFont.systemFont(ofSize: 12, weight: .semibold), custom.paragraphStyle: NSMutableParagraphStyle()])
        button.setAttributedTitle(attributedText, for: .normal)
        button.contentHorizontalAlignment = .leading
        
        return button
    }()
    let button: GradientButton = {
        let button = GradientButton("Далі", fontSize: 18, fontColor: .white, fontWeight: .semibold, gradientColors: [UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1), UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1)])
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        
        return button
    }()
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(self.alertView)
        self.alertView.addSubviews([self.checkbox, self.textLabel, self.linkButton, self.button])
        
        setupLayout()
    }
    
    private func setupLayout() {
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.alertView.backgroundColor = .white
        self.alertView.elevate(cornerRadius: 8, elevation: 2)
        
        self.alertView.anchor(centerY: self.view.centerYAnchor, centerX: self.view.centerXAnchor)
        self.alertView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        self.alertView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        self.checkbox.anchor(leading: self.alertView.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0), size: CGSize(width: 42, height: 42))
        self.checkbox.centerYAnchor.constraint(equalTo: self.textLabel.centerYAnchor).isActive = true
        
        self.textLabel.anchor(top: self.alertView.topAnchor, leading: self.checkbox.trailingAnchor, trailing: self.alertView.trailingAnchor, padding: UIEdgeInsets(top: 33, left: 8, bottom: 0, right: 16))
        
        self.linkButton.anchor(top: self.textLabel.bottomAnchor, leading: self.textLabel.leadingAnchor, trailing: self.textLabel.trailingAnchor, padding: UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0))
        
        self.button.anchor(leading: self.alertView.leadingAnchor, bottom: self.alertView.bottomAnchor, trailing: self.alertView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 22, bottom: 30, right: 22))
    }

}

extension ModalViewController {
    
    @objc private func activate(_ sender: UIButton!) {
        self.isActive.toggle()
    }
    
    @objc private func dismiss(_ sender: UIButton!) {
        self.delegate?.dismiss()
    }
    
}
