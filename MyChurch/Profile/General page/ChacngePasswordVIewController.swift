//
//  ChacngePasswordVIewController.swift
//  MyChurch
//
//  Created by Zhekon on 29.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class ChacngePasswordVIewController: UIViewController {
    
    let mainView = ChacngePasswordVIew()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.mainView.enterButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        self.mainView.remindPasswordButton.addTarget(self, action: #selector(remindPassPressed), for: .touchUpInside)
    }
    
    @objc func remindPassPressed() {
        let vc = RemindPassViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changePassword() {
        if mainView.newPassField.text?.count ?? 0 > 0 && mainView.oldPassField.text?.count ?? 0 > 0 {
            changePasswordApi(oldPass: mainView.oldPassField.text! , newPassword: mainView.newPassField.text!) { (result) in
                switch result {
                case .success(let data):
                    print(data.data)
                    let alert = UIAlertController(title: "Змiна паролю", message: "Пароль успішно змінено", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: { (action: UIAlertAction!) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                case .partialSuccess( _): break
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            let alert = UIAlertController(title: "Помилка", message: "Перевiрте правильнiсть введених полiв", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    @objc override func dismissKeyboard() {
        view.endEditing(true) //скрыть клаву по нажатию на экран
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.title = "Зміна паролю"
    }
}
