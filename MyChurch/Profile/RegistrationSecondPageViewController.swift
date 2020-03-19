//
//  RegistrationSecondPageViewController.swift
//  MyChurch
//
//  Created by Zhekon on 19.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class RegistrationSecondPageViewController: UIViewController {
    
    let mainView = RegistrationSecondPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        self.mainView.arhieriyButton.addTarget(self, action: #selector(openNumberPage), for: .touchUpInside)
        self.mainView.believerButton.addTarget(self, action: #selector(openNumberPage), for: .touchUpInside)
        self.mainView.clergyButton.addTarget(self, action: #selector(openNumberPage), for: .touchUpInside)
    }
    
    @objc func openNumberPage() {
        let vc = RegistrationThirdPageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.title = "Особистий кабінет"
    }
    
}
