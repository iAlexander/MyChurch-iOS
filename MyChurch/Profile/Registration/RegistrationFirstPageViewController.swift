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
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
            self.title = "Особистий кабінет"
           self.navigationController!.navigationBar.tintColor = .white
           self.navigationController?.navigationBar.topItem?.title = ""
       }
    
    @objc func charityPressed() {
        print("charityPressed")
    }
    
    @objc func personalAreaPressed() {
        if let data = UserDefaults.standard.value(forKey:"UserData") as? Data {
            let userData = try? PropertyListDecoder().decode(UserDatas.self, from: data)
            if userData?.data?.firstName?.count ?? 0 > 0 &&  userData?.data?.lastName?.count ?? 0 > 0 {
                let vc = GeneralPageProfileViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = LoginViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func spiritualSupportPressed() {
        print("spiritualSupportPressed")
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
    }
}
