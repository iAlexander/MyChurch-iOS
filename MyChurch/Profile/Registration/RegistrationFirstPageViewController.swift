//
//  ProfileViewController.swift
//  MyChurch
//
//  Created by Zhekon on 19.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class RegistrationFirstPageViewController: UIViewController {
    
    let mainView = RegistrationFirstPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        self.mainView.charityButton.addTarget(self, action: #selector(charityPressed), for: .touchUpInside)
        self.mainView.personalAreaButton.addTarget(self, action: #selector(personalAreaPressed), for: .touchUpInside)
        self.mainView.spiritualSupportButton.addTarget(self, action: #selector(spiritualSupportPressed), for: .touchUpInside)
    }
    
    @objc func charityPressed() {
        print("charityPressed")
    }
    
    @objc func personalAreaPressed() {
        let vc = RegistrationSecondPageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func spiritualSupportPressed() {
        print("spiritualSupportPressed")
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.title = "Особистий кабінет"
    }
}
