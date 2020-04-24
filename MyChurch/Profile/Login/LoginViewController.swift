//
//  LoginViewController.swift
//  MyChurch
//
//  Created by Zhekon on 28.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit
import ANLoader

class LoginViewController: UIViewController {
    
    let mainView = LoginView()
    var userData : UserDatas?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.mainView.enterButton.addTarget(self, action: #selector(enterPressed), for: .touchUpInside)
        self.mainView.createAccount.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        self.mainView.remindPasswordButton.addTarget(self, action: #selector(remindPassPressed), for: .touchUpInside)
    }
    
    @objc func remindPassPressed() {
        if self.mainView.emailField.text?.count ?? 0 > 0 {
            ANLoader.showLoading()
            rememberPassApi(email: mainView.emailField.text! ) { (result) in
                switch result {
                case .success(let data):
                    print(data)
                    if data.ok == true {
                        let alert = UIAlertController(title: "Нагати пароль", message: "Перевiрте вашу пошту \( self.mainView.emailField.text!)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: { (action: UIAlertAction!) in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        ANLoader.hide()
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Помилка", message: "Цей email не зареєстровано, перевiрте поле email", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
                        ANLoader.hide()
                        self.present(alert, animated: true, completion: nil)
                    }
                case .partialSuccess( _):ANLoader.hide()
                case .failure(let error): ANLoader.hide()
                print(error)
                }
            }
        }  else {
            let alert = UIAlertController(title: "Помилка", message: "Заповнiть поле email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
            ANLoader.hide()
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func createAccount() {
        let vc = RegistrationSecondPageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func enterPressed() {
        if mainView.emailField.text?.count ?? 0 > 1 && mainView.passwordField.text?.count ?? 0 > 1 {
            ANLoader.showLoading()
            signUpUser(email: mainView.emailField.text!, password: mainView.passwordField.text! ) { (result) in
                switch result {
                case .success(let data):
                    print(data)
                    UserDefaults.standard.set(data.data?.accessToken, forKey: "BarearToken")                        
                    getUserData() { (result) in
                        switch result {
                        case .success(let data):
                            ANLoader.hide()
                            self.userData = data
                            if data.data == nil {
                                let alert = UIAlertController(title: "Помилка", message: "Неправильний логiн або пароль", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
                                ANLoader.hide()
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                UserDefaults.standard.set(try? PropertyListEncoder().encode(self.userData), forKey:"UserData") //сохранил в юзердефолтс данные пользователя
                            let vc = GeneralPageProfileViewController()
                            self.navigationController?.show(vc, sender: nil)
                            }
                        case .partialSuccess( _):  ANLoader.hide(); self.errorAllert()
                        case .failure(let error):  ANLoader.hide(); self.errorAllert()
                        print(error)
                        }
                    }
                case .partialSuccess( _):  ANLoader.hide(); self.errorAllert()
                case .failure(let error):  ANLoader.hide() ; self.errorAllert()
                print(error)
                }
            }
        } else {
            let alert = UIAlertController(title: "Помилка", message: "Заповнiть усi поля", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.title = "Особистий кабінет"
    }
    
    func errorAllert() {
        let alert = UIAlertController(title: "Помилка", message: "Логiн або пароль введено неправильно", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true) //скрыть клаву по нажатию на экран
    }
    
    
    @objc func personalAreaPressed() {
        let vc = RegistrationSecondPageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

