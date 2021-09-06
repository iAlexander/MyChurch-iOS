//
//  SupportPageViewController.swift
//  MyChurch
//
//  Created by Zhekon on 15.05.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class SupportPageViewController: UIViewController {
    
    let mainView = SupportView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        mainView.fbSupportButton.addTarget(self, action: #selector(suppPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "Духовна пiдтримка"
    }
    
    @objc func suppPressed() {
        if let url = URL(string: "https://www.facebook.com/Orthodox.in.Ukraine") {
            UIApplication.shared.open(url)
        }
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
    }
}
