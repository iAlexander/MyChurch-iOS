//
//  RegistrationFourthPageViewController.swift
//  MyChurch
//
//  Created by Zhekon on 21.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class RegistrationFourthPageViewController: UIViewController, UITextFieldDelegate {
    
    let mainView = RegistrationFourthPageView()
    var phoneNumber = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        mainView.sendCodeButton.addTarget(self, action: #selector(nextPagePressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
            self.title = "Реєстрація"
           self.navigationController!.navigationBar.tintColor = .white
           self.navigationController?.navigationBar.topItem?.title = ""
       }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case  mainView.smsTextField:
            let oldString = textField.text
            var oldRawString = rawStringFrom(displayString: oldString!)
            switch string {
            case "":
                oldRawString.removeLast()
            case "0","1","2","3","4","5","6","7","8","9" :
                oldRawString = oldRawString + string
                if  oldRawString.count >= 5 {
                    return false
                }
            default: return false
            }
            
            if  oldRawString.count >= 4 {
                mainView.sendCodeButton.layer.backgroundColor = UIColor(red: 0.004, green: 0.478, blue: 0.898, alpha: 1).cgColor
            } else {
                mainView.sendCodeButton.layer.backgroundColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
            }
            return true
        default: return true
        }
    }
  
    func rawStringFrom(displayString: String) -> String {
        let arrayOfDigits = displayString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        let result = arrayOfDigits.joined(separator: "")
        return result
    }
    
    @objc func nextPagePressed() {
        let vc = RegistrationFifthPageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func ConfigView() {
        self.mainView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(mainView)
        self.title = "Реєстрація"
        mainView.smsTextField.delegate = self
        mainView.writePhoneTopLabel.text = "Код було відправлено на\n\(phoneNumber)"
    }
}
