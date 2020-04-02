//
//  RemindPassViewController.swift
//  MyChurch
//
//  Created by Zhekon on 01.04.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit
import ANLoader

class RemindPassViewController: UIViewController {

     let mainView = RemindPassView()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         ConfigView()
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
         view.addGestureRecognizer(tap)
         self.mainView.enterButton.addTarget(self, action: #selector(remindPassPressed), for: .touchUpInside)
     }
     
      @objc func remindPassPressed() {
         if self.mainView.oldPassField.text?.count ?? 0 > 0 {
             ANLoader.showLoading()
             rememberPassApi(email: mainView.oldPassField.text! ) { (result) in
                 switch result {
                 case .success(let data):
                     print(data)
                     if data.ok == true {
                         let alert = UIAlertController(title: "Нагати пароль", message: "Перевiрте вашу пошту \( self.mainView.oldPassField.text!)", preferredStyle: .alert)
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
     
     
     @objc override func dismissKeyboard() {
         view.endEditing(true) //скрыть клаву по нажатию на экран
     }
     
     func ConfigView() {
         self.view.addSubview(mainView)
         self.mainView.frame = self.view.bounds
         self.title = "Нагадування паролю"
     }
}
