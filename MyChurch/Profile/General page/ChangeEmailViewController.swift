//
//  ChacngeEmailVIewController.swift
//  MyChurch
//
//  Created by Zhekon on 01.04.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class ChangeEmailViewController: UIViewController {
    
    let mainView = ChangeEmailView()
    var userUid = String()
    var email = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.mainView.enterButton.addTarget(self, action: #selector(changeEmail), for: .touchUpInside)

    }
  
    @objc func changeEmail() {
        if  mainView.oldPassField.text?.count ?? 0 > 0 {
            changeEmailApi(newEmail: mainView.oldPassField.text! ) { (result) in
                switch result {
                case .success(let data):
                    print(data)
                    self.email = self.mainView.oldPassField.text!
                    self.userUid = data.data?.userUid ?? ""
                    let alert = UIAlertController(title: "Змiна email", message: "Ваш email успiшно змiнено на новий", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: { (action: UIAlertAction!) in
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
        self.title = "Зміна email"
    }
}
