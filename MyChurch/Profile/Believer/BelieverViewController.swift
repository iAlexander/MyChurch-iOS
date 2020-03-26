//
//  BelieverViewController.swift
//  MyChurch
//
//  Created by Zhekon on 25.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class BelieverViewController: UIViewController, SendDataDelegate {
   
    func hramName(name: String, isEparhiya: Bool) {
        if !isEparhiya {
            mainView.hramLabelButton.text = name
        } else {
            mainView.eparhiyaLabel.text = name
        }
    }
    
    let mainView = BelieverView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        self.mainView.chooseStatusButton.addTarget(self, action: #selector(statusPressed), for: .touchUpInside)
        self.mainView.believerButton.addTarget(self, action: #selector(believerPressed), for: .touchUpInside)
        self.mainView.chlenParafRaduButton.addTarget(self, action: #selector(chlenParafRaduButtonPressed), for: .touchUpInside)
        self.mainView.chooseHramButton.addTarget(self, action: #selector(chooseHramPressed), for: .touchUpInside)
        self.mainView.eparhiyaButton.addTarget(self, action: #selector(chooseEparhiyaPressed), for: .touchUpInside)
    }
    
    @objc func chooseHramPressed() {
        let vc = ChooseHramViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func chooseEparhiyaPressed() {
          let vc = ChooseEparhiesViewController()
          vc.delegate = self
          self.navigationController?.pushViewController(vc, animated: true)
      }
    
    @objc func statusPressed() {
        self.mainView.believerButton.isHidden = false
        self.mainView.chlenParafRaduButton.isHidden = false
        mainView.hramLabel.isHidden = true
    }
    
    @objc func believerPressed() {
        mainView.statusLabel.text = "Вірянин"
        self.mainView.believerButton.isHidden = true
        self.mainView.chlenParafRaduButton.isHidden = true
        mainView.hramLabel.isHidden = false
    }
    
    @objc func chlenParafRaduButtonPressed() {
        mainView.statusLabel.text = "Член парафіяльної ради"
        self.mainView.believerButton.isHidden = true
        self.mainView.chlenParafRaduButton.isHidden = true
        mainView.hramLabel.isHidden = false
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.title = "Особистий кабінет"
        self.mainView.believerButton.isHidden = true
        self.mainView.chlenParafRaduButton.isHidden = true
    }
}
