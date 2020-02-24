//
//  OnboardingViewController.swift
//  MyChurch
//
//  Created by Oleksandr Lohozinskyi on 23.02.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class OnboardingViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLayout()
    }
    
    private func setupLayout() {
        self.tabBarController?.tabBar.backgroundColor = .white
        
    }

}
