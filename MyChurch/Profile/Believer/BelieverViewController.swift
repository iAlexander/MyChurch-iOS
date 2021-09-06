//
//  BelieverViewController.swift
//  MyChurch
//
//  Created by Zhekon on 25.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class BelieverViewController: UIViewController, SendDataDelegate, SendDataEparhiyaDelegate, SendStatusDelegate {
    
    func statusType(name: String) {
        mainView.statusLabel.text = name
    }
    
 
    func hramName(name: String, hramId: Int) { //делегат, который возвращает храм и его айди
        mainView.hramLabelButton.text = name
        self.hramId = hramId
        checkInfo()
    }
    
    func eparhiyaName(name: String, eparhiyaId: Int) { //делегат, который возвращает епархию и его айди
        mainView.eparhiyaLabel.text = name
        self.eparhiyaId = eparhiyaId
        checkInfo()
    }
    
    let mainView = BelieverView()
    var birthDate = Date()
    var member = String()
    var hramId = Int()
    var eparhiyaId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        ConfigButtons()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        self.title = "Реєстрація"
           self.navigationController!.navigationBar.tintColor = .white
//           self.navigationController?.navigationBar.topItem?.title = ""
        checkInfo()
       }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true) //скрыть клаву по нажатию на экран
        checkInfo()
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.mainView.believerButton.isHidden = true
        self.mainView.chlenParafRaduButton.isHidden = true
        mainView.emailTextField.delegate = self
        mainView.birthdayDate.maximumDate = Date()
    }
    
    func ConfigButtons() {
        self.mainView.chooseStatusButton.addTarget(self, action: #selector(statusPressed), for: .touchUpInside)
        self.mainView.believerButton.addTarget(self, action: #selector(believerPressed), for: .touchUpInside)
        self.mainView.chlenParafRaduButton.addTarget(self, action: #selector(chlenParafRaduButtonPressed), for: .touchUpInside)
        self.mainView.chooseHramButton.addTarget(self, action: #selector(chooseHramPressed), for: .touchUpInside)
        self.mainView.eparhiyaButton.addTarget(self, action: #selector(chooseEparhiyaPressed), for: .touchUpInside)
        self.mainView.saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        self.mainView.birthdayDate.addTarget(self, action: #selector(handler), for: .valueChanged)
    }
    
    @objc func handler(sender: UIDatePicker) { //барабан даты
        var timeInterval = DateComponents()
        timeInterval.hour = 5
    }
    
    @objc func savePressed() {
        switch mainView.statusLabel.text {
        case "Вірянин": self.member = "Parishioner"
        case "Член парафіяльної ради": self.member = "Mpc"
        default: break
        }
        registrationUser(name: mainView.nameTextField.text!, serName: mainView.serNameTextField.text!, birthday: mainView.birthdayDate.date.description, phone: mainView.phoneTextField.text!, email: mainView.emailTextField.text! , status: self.member, hram: self.hramId, eparhiya: self.eparhiyaId, angelday: "" ) { (result) in
            switch result {
            case .success(let data):
                if data.ok ?? false {
                UserDefaults.standard.set(data.data?.accessToken, forKey: "BarearToken")
                let vc = GeneralPageProfileViewController()
                vc.member = self.member
                vc.email = self.mainView.emailTextField.text ?? ""
                    let userData = UserDatas(data: UserInfo(firstName: self.mainView.nameTextField.text!, lastName: self.mainView.serNameTextField.text!, email: self.mainView.emailTextField.text!, phone: "", church: Church(name: self.mainView.eparhiyaLabel.text, locality: "")))
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(userData), forKey:"UserData") //сохранил в юзердефолтс данные пользователя
                    self.navigationController?.show(vc, sender: nil)
                    if let current = self.navigationController?.viewControllers.firstIndex(of: self) {
                        self.navigationController?.viewControllers.remove(at: current)
                    }
                } else {
                    let alert = UIAlertController(title: "Помилка", message: "Перевiрте данi реєстрацiï", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Добре", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            case .partialSuccess( _): break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func chooseHramPressed() {
        let vc = ChooseHramViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func chooseEparhiyaPressed() {
        let vc = ChooseEparhiesViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func statusPressed() {
        let vc = ChooseStatusVC()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
//        self.mainView.believerButton.isHidden = false
//        self.mainView.chlenParafRaduButton.isHidden = false
//        mainView.hramLabel.isHidden = true
        
    }
    
    @objc func believerPressed() {
        mainView.statusLabel.text = "Вірянин"
        self.mainView.believerButton.isHidden = true
        self.mainView.chlenParafRaduButton.isHidden = true
        mainView.hramLabel.isHidden = false
    }
    
    @objc func chlenParafRaduButtonPressed() {
        mainView.statusLabel.text = "Член парафіяльної ради"
        self.mainView.believerButton.isHidden = true
        self.mainView.chlenParafRaduButton.isHidden = true
        mainView.hramLabel.isHidden = false
    }
    
    func checkInfo() { // чекаю кнопку при введенных данных && mainView.hramLabelButton.text != "Оберіть свій Храм" && mainView.eparhiyaLabel.text !=  "Оберіть свою єпархію"
        if mainView.nameTextField.text?.count ?? 0 > 1 && mainView.serNameTextField.text?.count ?? 0 > 1 && mainView.phoneTextField.text?.count ?? 0 > 1 && mainView.emailTextField.text?.count ?? 0 > 1  {
            mainView.saveButton.isEnabled = true; mainView.saveButton.backgroundColor =  UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1)
        } else {
            mainView.saveButton.isEnabled = false; mainView.saveButton.backgroundColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
        }
    }
}

extension BelieverViewController: UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        checkInfo()
        if textField == mainView.emailTextField {
            do {
                let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9 ._%+-@].*", options: [])
                if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                    return false
                }
            }
            catch {
                print("ERROR")
            }
        }
        return true
    }
}
