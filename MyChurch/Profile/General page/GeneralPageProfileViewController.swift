//
//  GeneralPageProfileViewController.swift
//  MyChurch
//
//  Created by Zhekon on 27.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class GeneralPageProfileViewController: UIViewController {
    
    let mainView = GeneralPageProfileView()
    var member = String()
    var email = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        showInfoWindows()
        if let data = UserDefaults.standard.value(forKey:"UserData") as? Data {
            let userData = try? PropertyListDecoder().decode(UserDatas.self, from: data)
            mainView.nameSername.text = "\(userData?.data?.firstName ?? "") \(userData?.data?.lastName ?? "")"
            print(userData as Any)
        }
        self.mainView.changePassword.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        self.mainView.changeEmail.addTarget(self, action: #selector(changeEmail), for: .touchUpInside)
    }
    
    @objc func changePassword() {
        let vc = ChacngePasswordVIewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changeEmail() {
         let vc = ChangeEmailViewController()
         self.navigationController?.pushViewController(vc, animated: true)
     }
    
    func showInfoWindows() {
        switch member {
        case "Parishioner": let alert = UIAlertController(title: "Реєстрацiя успiшна", message: "Пароль від кабінету відправили на \n\(email)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        case "Mpc": let alert = UIAlertController(title: "Реєстрацiя на модерацiï", message: "Пароль від кабінету відправили на\n\(email)\n\nПрофіль знаходиться на верифікації.\nМи перевіремо ваші дані найближчим часом, це може зайняти декілька днів", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        case "Priest": let alert = UIAlertController(title: "Реєстрацiя на модерацiï", message: "Пароль від кабінету відправили на\n\(email)\n\nПрофіль знаходиться на верифікації.\nМи перевіремо ваші дані найближчим часом, це може зайняти декілька днів", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        case "PriestPro": let alert = UIAlertController(title: "Реєстрацiя на модерацiï", message: "Пароль від кабінету відправили на\n\(email)\n\nПрофіль знаходиться на верифікації.\nМи перевіремо ваші дані найближчим часом, це може зайняти декілька днів", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        default: break
        }
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.navigationItem.hidesBackButton = true
        self.title = "Особистий кабiнет"
    }
}
