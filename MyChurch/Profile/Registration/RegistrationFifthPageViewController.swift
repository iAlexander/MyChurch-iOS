//
//  RegistrationFifthPageViewController.swift
//  MyChurch
//
//  Created by Zhekon on 21.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class RegistrationFifthPageViewController: UIViewController, UITextFieldDelegate {

    let mainView = RegistrationFifthPageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        mainView.codeField.becomeFirstResponder()
        mainView.codeField.isHidden = true
        mainView.codeField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case  mainView.codeField:
            let oldString = textField.text
            var oldRawString = rawStringFrom(displayString: oldString!)
            switch string {
            case "":
                oldRawString.removeLast()
            case "0","1","2","3","4","5","6","7","8","9" :
                oldRawString = oldRawString + string
                if  oldRawString.count >= 7 {
                    return false
                }
            default: return false
            }
            switch oldRawString.count {
            case 0:  mainView.firstSymbolCode.image = UIImage(named: "passLock"); mainView.secondSymbolCode.image = UIImage(named: "passLock"); mainView.thirdSymbolCode.image = UIImage(named: "passLock"); mainView.fourthSymbolCode.image = UIImage(named: "passLock");mainView.fifthSymbolCode.image = UIImage(named: "passLock");mainView.sixthSymbolCode.image = UIImage(named: "passLock");
            case 1: mainView.firstSymbolCode.image = UIImage(named: "passEntered"); mainView.secondSymbolCode.image = UIImage(named: "passLock"); mainView.thirdSymbolCode.image = UIImage(named: "passLock");mainView.fourthSymbolCode.image = UIImage(named: "passLock");mainView.fifthSymbolCode.image = UIImage(named: "passLock");mainView.sixthSymbolCode.image = UIImage(named: "passLock");
            case 2: mainView.secondSymbolCode.image = UIImage(named: "passEntered"); mainView.thirdSymbolCode.image = UIImage(named: "passLock");mainView.fourthSymbolCode.image = UIImage(named: "passLock");mainView.fifthSymbolCode.image = UIImage(named: "passLock");mainView.sixthSymbolCode.image = UIImage(named: "passLock");
            case 3: mainView.thirdSymbolCode.image = UIImage(named: "passEntered");mainView.fourthSymbolCode.image = UIImage(named: "passLock");mainView.fifthSymbolCode.image = UIImage(named: "passLock");mainView.sixthSymbolCode.image = UIImage(named: "passLock");
            case 4: mainView.fourthSymbolCode.image = UIImage(named: "passEntered");mainView.fifthSymbolCode.image = UIImage(named: "passLock");mainView.sixthSymbolCode.image = UIImage(named: "passLock");
            case 5: mainView.fifthSymbolCode.image = UIImage(named: "passEntered");mainView.sixthSymbolCode.image = UIImage(named: "passLock");
            case 6:  mainView.sixthSymbolCode.image = UIImage(named: "passEntered");
            default: break
            }
            if oldRawString.count >= 6 {
                print(oldRawString)
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
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.title = "Особистий кабінет"
    }
}
