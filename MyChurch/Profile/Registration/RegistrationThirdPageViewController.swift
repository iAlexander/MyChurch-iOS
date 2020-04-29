//
//  RegistrationThirdPageViewController.swift
//  MyChurch
//
//  Created by Zhekon on 19.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class RegistrationThirdPageViewController: UIViewController, UITextFieldDelegate {
    
    let mainView = RegistrationThirdPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        mainView.sendCodeButton.addTarget(self, action: #selector(nextPagePressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
            self.title = "Особистий кабінет"
           self.navigationController!.navigationBar.tintColor = .white
           self.navigationController?.navigationBar.topItem?.title = ""
       }
    
    @objc func nextPagePressed() {
        let vc = RegistrationFourthPageViewController()
        vc.phoneNumber = mainView.numberTextField.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case  mainView.numberTextField:
            let oldString = textField.text
            let newString = oldString! + string
            if newString.count <= 6 || newString.count > 19 {
                return false
            } else {
                var oldRawString = rawStringFrom(displayString: oldString!)
                switch string {
                case "":
                    oldRawString.removeLast()
                case "0","1","2","3","4","5","6","7","8","9" :
                    oldRawString = oldRawString + string
                default :
                    return false
                }
                textField.text = displayStringFrom(rawString: oldRawString)
                if  textField.text?.count ?? 0 >= 19 {
                    mainView.sendCodeButton.layer.backgroundColor = UIColor(red: 0.004, green: 0.478, blue: 0.898, alpha: 1).cgColor
                } else {
                    mainView.sendCodeButton.layer.backgroundColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
                }
            }
            return false
        default:
            return true
        }
    }
    
    func rawStringFrom(displayString: String) -> String {
        let arrayOfDigits = displayString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        let result = arrayOfDigits.joined(separator: "")
        return result
    }
    
    func displayStringFrom(rawString: String?) -> String {
        if rawString != nil {
            var resultString = rawString
            if (resultString?.count)! >= 1 {
                resultString!.insert("+", at: resultString!.startIndex)
            }
            if (resultString?.count)! >= 3 {
                resultString!.insert(" ", at: resultString!.index(resultString!.startIndex, offsetBy: 3))
                resultString!.insert("(", at: resultString!.index(resultString!.startIndex, offsetBy: 4))
            }
            if (resultString?.count)! >= 8 {
                resultString!.insert(")", at: resultString!.index(resultString!.startIndex, offsetBy: 8))
                resultString!.insert(" ", at: resultString!.index(resultString!.startIndex, offsetBy: 9))
            }
            if (resultString?.count)! >= 13 {
                resultString!.insert("-", at: resultString!.index(resultString!.startIndex, offsetBy: 13))
            }
            if (resultString?.count)! >= 16 {
                resultString!.insert("-", at: resultString!.index(resultString!.startIndex, offsetBy: 16))
            }
            return resultString!
        } else {
            return "+38 (0"
        }
    }
    
    func ConfigView() {
        self.mainView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(mainView)
        self.title = "Особистий кабінет"
        mainView.numberTextField.delegate = self
    }
}
