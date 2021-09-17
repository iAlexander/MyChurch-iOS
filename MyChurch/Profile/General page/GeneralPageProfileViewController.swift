//
//  GeneralPageProfileViewController.swift
//  MyChurch
//
//  Created by Zhekon on 27.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class GeneralPageProfileViewController: ViewController {
    
    let mainView = GeneralPageProfileView()
    var member = String()
    var email = String()
    var church = String()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController!.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
        switch UserData.defaultScreenIndex  {
        case 0: self.mainView.startScreenButtonText.text = "Карта"
        case 1: self.mainView.startScreenButtonText.text = "Календар"
        case 2: self.mainView.startScreenButtonText.text = "Новини"
        case 3: self.mainView.startScreenButtonText.text = "Молитви"
        case 4: self.mainView.startScreenButtonText.text = "Мій профіль"
        default: break
        }
        self.mainView.layoutSubviews()
        self.title = "Мій профіль"
        if UserDefaults.standard.string(forKey: "BarearToken") == nil {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        showInfoWindows()
        if let data = UserDefaults.standard.value(forKey:"UserData") as? Data {
            let userData = try? PropertyListDecoder().decode(UserDatas.self, from: data)
            mainView.peopleType.text = setMemberLabel(member: userData?.data?.member)
            mainView.nameSername.text = "\(userData?.data?.firstName ?? "") \(userData?.data?.lastName ?? "")"
            print(userData as Any)
        }
        self.mainView.changePassword.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        self.mainView.changeEmail.addTarget(self, action: #selector(changeEmail), for: .touchUpInside)
        self.mainView.startScreenButton.addTarget(self, action: #selector(chooseStartScreen), for: .touchUpInside)
        self.mainView.donateView.addTarget(self, action: #selector(donatePressed), for: .touchUpInside)
    }
    
    private func setMemberLabel(member: UserInfo.MemberType?) -> String {
        switch member {
        case .Mpc:
            return "Член парафіяльної ради"
        case .Parishioner:
            return "Вірянин"
        case .Priest:
            return "Духовенство"
        case .PriestPro:
            return "Архієрей"
        case .none:
            return ""
        }
    }
    
    @objc func donatePressed() {
        let vc = RegularDonateViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
    @objc func changePassword() {
        let vc = ChacngePasswordVIewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changeEmail() {
         let vc = ChangeEmailViewController()
         self.navigationController?.pushViewController(vc, animated: true)
     }
    
    @objc func chooseStartScreen() {
        let vc = ChooseStartScreenViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openNotification(_ sender: UIButton!) {
        let vc = NotificationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
     
    
    func showInfoWindows() {
        switch member {
        case "Parishioner": let alert = UIAlertController(title: "Реєстрацiя успiшна", message: "Ваш пароль відправлено на пошту на \n\(email)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        case "Mpc": let alert = UIAlertController(title: "Реєстрацiя на модерацiï", message: "Ваш пароль відправлено на пошту\n\(email)\n\nПрофіль знаходиться на верифікації.\nМи перевіремо ваші дані найближчим часом, це може зайняти декілька днів", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        case "Priest": let alert = UIAlertController(title: "Реєстрацiя на модерацiï", message: "Ваш пароль відправлено на пошту\n\(email)\n\nПрофіль знаходиться на верифікації.\nМи перевіремо ваші дані найближчим часом, це може зайняти декілька днів", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        case "PriestPro": let alert = UIAlertController(title: "Реєстрацiя на модерацiï", message: "Ваш пароль відправлено на пошту\n\(email)\n\nПрофіль знаходиться на верифікації.\nМи перевіремо ваші дані найближчим часом, це може зайняти декілька днів", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        default: break
        }
    }
    
    func ConfigView() {
        self.view = mainView
        self.navigationItem.hidesBackButton = false
        mainView.exitButton.addTarget(self, action: #selector(exitPressed), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = notificationhBarButtonItem
        super.notificationhBarButtonItem.action = #selector(openNotification(_:))
    }
    
    @objc func exitPressed() {
         UserDefaults.standard.set(nil, forKey:"UserData")
        UserDefaults.standard.setValue(nil, forKey: "BarearToken")
        navigationController?.popToRootViewController(animated: true)
    }
}
