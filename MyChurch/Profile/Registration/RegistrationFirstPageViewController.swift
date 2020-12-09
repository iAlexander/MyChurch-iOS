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
       }
    
    @objc func charityPressed() {
        sendLikPayData(value: "paydonate") { (result) in
            switch result {
            case .success(let data):
                if data.ok ?? false {
                    let vc = WebViewController()
                    vc.liqPayUrl = data.data!.url!
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let alertController = UIAlertController(title: "Помилка", message: "втрачений звз'язок с сервером, спробуйте пiзнiше", preferredStyle: .alert)
                    let actionCancel = UIAlertAction(title: "закрити", style: .cancel) { (action:UIAlertAction) in
                    }
                    alertController.addAction(actionCancel)
                    self.present(alertController, animated: true, completion: nil)
                }
            case .partialSuccess( _):  print("error")
            case .failure(let error):  print(error.localizedDescription)
            print(error)
            }
        }
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
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
    }
}
