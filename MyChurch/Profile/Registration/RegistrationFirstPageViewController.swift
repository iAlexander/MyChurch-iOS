//
//  ProfileViewController.swift
//  MyChurch
//
//  Created by Zhekon on 19.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class RegistrationFirstPageViewController: ViewController {
    
    let mainView = RegistrationFirstPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        self.mainView.charityButton.addTarget(self, action: #selector(charityPressed), for: .touchUpInside)
        self.mainView.personalAreaButton.addTarget(self, action: #selector(personalAreaPressed), for: .touchUpInside)
        self.mainView.spiritualSupportButton.addTarget(self, action: #selector(spiritualSupportPressed), for: .touchUpInside)
        self.mainView.technicalSupportButton.addTarget(self, action: #selector(openTechnicalSupport(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = false
        self.title = "Мій профіль"
        self.mainView.personalAreaButton.setTitle(UserDefaults.standard.string(forKey: "BarearToken") == nil ? "Вхід / Реєстрація" : "Налаштування", for: .normal)
        self.navigationController!.navigationBar.tintColor = .white
        if UserDefaults.standard.string(forKey: "BarearToken") == nil {
            self.navigationItem.rightBarButtonItem = nil
            self.mainView.personalAreaButton.setTitle("Вхід / Реєстрація", for: .normal)
        } else {
            self.mainView.personalAreaButton.setTitle("Налаштування", for: .normal)
        }
    }
    
    @objc func charityPressed() {
        let vc = DonateInformationVC()
        self.navigationController?.pushViewController(vc, animated: true)
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
        let vc = SupportPageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openNotification(_ sender: UIButton!) {
        let vc = NotificationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openTechnicalSupport(_ sender: UIButton!) {
        let vc = TechnicalSupportVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.navigationItem.rightBarButtonItem = notificationhBarButtonItem
        super.notificationhBarButtonItem.action = #selector(openNotification(_:))
    }
}
