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
        self.mainView.believerButton.addTarget(self, action: #selector(believerButtonPressed), for: .touchUpInside)
        self.mainView.arhieriyButton.addTarget(self, action: #selector(arhieriyButtonPressed), for: .touchUpInside)
        self.mainView.clergyButton.addTarget(self, action: #selector(clergyButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
            self.title = "Реєстрація"
           self.navigationController!.navigationBar.tintColor = .white
           self.navigationController?.navigationBar.topItem?.title = ""
       }
    
    @objc func believerButtonPressed() {
        let vc = BelieverViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clergyButtonPressed() {
          let vc = DuhovenstvoViewController()
          self.navigationController?.pushViewController(vc, animated: true)
      }
    
    @objc func arhieriyButtonPressed() {
             let vc = ArhieriyViewController()
             self.navigationController?.pushViewController(vc, animated: true)
         }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.title = "Мій профіль"
    }
}
