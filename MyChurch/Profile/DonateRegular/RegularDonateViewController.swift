//
//  RegularDonateViewController.swift
//  MyChurch
//
//  Created by Zhekon on 10.08.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class RegularDonateViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
 
    let mainView = RegularDonateView()
    var userData = UserDatas()
    var historyData : HistoryLiqPayData?
    private let reuseIdentifierTableView = "CalendarCellTableView"

    override func viewDidLoad() {
        super.viewDidLoad()
        сonfigView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = UserDefaults.standard.value(forKey:"UserData") as? Data {
            let userData = try? PropertyListDecoder().decode(UserDatas.self, from: data)
            self.userData = userData!
            if userData?.data?.subscriptionStatus == "Subscribed" {
                mainView.subscribeButton.addTarget(self, action: #selector(antiDonatePressed), for: .touchUpInside)
                mainView.subscribeButton.setTitle("Вiдписатись", for: .normal)
                mainView.needDonateLabel.isHidden = true
                mainView.summasLabel.isHidden = true
                mainView.moneyField.isHidden = true
                mainView.bottomGrayLine.isHidden = true
                self.mainView.historyTable.isHidden = false
                getHistoryLiqPay() { (result) in
                    switch result {
                    case .success(let data):
                        print(data)
                        self.historyData = data
                        self.mainView.historyTable.reloadData()
                    case .partialSuccess(_): print("error")
                    case .failure(let error):  print(error.localizedDescription)
                    }
                }
            } else {
                mainView.subscribeButton.addTarget(self, action: #selector(donatePressed), for: .touchUpInside)
                mainView.subscribeButton.setTitle("Пiдписатись", for: .normal)
                mainView.needDonateLabel.isHidden = false
                mainView.summasLabel.isHidden = false
                mainView.moneyField.isHidden = false
                mainView.bottomGrayLine.isHidden = false
                self.mainView.historyTable.isHidden = true
            }
        }
    }
    
    func сonfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.title = "Благодiйний внесок"
        mainView.personInfoButton.addTarget(self, action: #selector(showPressed), for: .touchUpInside)
        mainView.moneyField.delegate = self
        mainView.historyTable.delegate = self
        mainView.historyTable.dataSource = self
        mainView.historyTable.register(HistoryCell.self, forCellReuseIdentifier: reuseIdentifierTableView)
        self.mainView.historyTable.tableFooterView = UIView()
        showPressed()
        hideKeyboard()
    }
    
    //MARK: Work with tableView
       func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 65
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historyData?.data?.list?.count ?? 0
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableView, for: indexPath) as! HistoryCell
        cell.cost.text =  String(self.historyData?.data?.list?[indexPath.row].amount?.description ?? "") + " грн"
        cell.date.text = self.historyData?.data?.list?[indexPath.row].time?.strstr(needle: "T", beforeNeedle: true)?.replacingOccurrences(of: "-", with: ".")
        if self.historyData?.data?.list?[indexPath.row].status == "Regular" || self.historyData?.data?.list?[indexPath.row].status == "Paydonate" {
            cell.statusImage.image = UIImage(named: "check")
        } else {
            cell.statusImage.image = UIImage(named: "declined")
        }
        return cell
    }
    
    func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self,  action: #selector(hideElements))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func antiDonatePressed() {
        deSubscribe() { (result) in
            switch result {
            case .success(let data):
                print(data)
                if data.ok == true {
                    self.userData.data?.subscriptionStatus = "unSubscribe"
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(self.userData), forKey:"UserData") //сохранил в юзердефолтс данные пользователя
                    self.viewWillAppear(true)
                    let alertController = UIAlertController(title: "Повiдомлення", message: "Ви успiшно вiдписалися", preferredStyle: .alert)
                    let actionCancel = UIAlertAction(title: "добре", style: .cancel) { (action:UIAlertAction) in
                    }
                    alertController.addAction(actionCancel)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Повiдомлення", message: data.errors?[0].message, preferredStyle: .alert)
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
    
    @objc func donatePressed() {
        var money = mainView.moneyField.text
        money = money?.strstr(needle: ".", beforeNeedle: true)
        let moneyInt = Int(money ?? "0")
        if moneyInt ?? 0 > 10 {
            sendLikPayDataSubscribe(value: "subscribe" , amount: money ?? "") { (result) in
                switch result {
                case .success(let data):
                    if data.ok ?? false {
                        let vc = WebViewController()
                        vc.liqPayUrl = data.data!.url!
                        vc.userData = self.userData
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        let alertController = UIAlertController(title: "Помилка", message: data.errors?[0].message, preferredStyle: .alert)
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
        } else {
            let alertController = UIAlertController(title: "Повiдомлення", message: "Мiнiмальна сума 10 грн", preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "добре", style: .cancel) { (action:UIAlertAction) in
            }
            alertController.addAction(actionCancel)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func hideElements() {
        view.endEditing(true)
        self.mainView.backView.isHidden = true
        self.mainView.arrowImage.image = UIImage(named: "downImage")
        self.mainView.personInfoButton.isSelected = true
    }
    
    @objc func showPressed() {
        self.mainView.personInfoButton.isSelected = !self.mainView.personInfoButton.isSelected
        if self.mainView.personInfoButton.isSelected {
            self.mainView.backView.isHidden = true
            self.mainView.historyTable.isHidden = false
            self.mainView.arrowImage.image = UIImage(named: "downImage")
        } else {
            self.mainView.backView.isHidden = false
            self.mainView.historyTable.isHidden = true
            self.mainView.arrowImage.image = UIImage(named: "topArrow")
        }
    }
}

class CurrencyTextField: UITextField {
    /// The numbers that have been entered in the text field
    private var enteredNumbers = ""
    
    private var didBackspace = false
    
    var locale: Locale = .current
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    override func deleteBackward() {
        enteredNumbers = String(enteredNumbers.dropLast())
        text = enteredNumbers.asCurrency(locale: locale)
        // Call super so that the .editingChanged event gets fired, but we need to handle it differently, so we set the `didBackspace` flag first
        didBackspace = true
        super.deleteBackward()
    }
    
    @objc func editingChanged() {
        defer {
            didBackspace = false
            var newText = enteredNumbers.asCurrency(locale: locale)
            text = newText?.strstr(needle: "UAH", beforeNeedle: true)?.replacingOccurrences(of: ",", with: ".")
            text = text?.dropLast().description
        }
        
        guard didBackspace == false else { return }
        if let lastEnteredCharacter = text?.last, lastEnteredCharacter.isNumber {
            enteredNumbers.append(lastEnteredCharacter)
        }
    }
}

private extension Formatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
}

private extension String {
    func asCurrency(locale: Locale) -> String? {
        Formatter.currency.locale = locale
        if self.isEmpty {
            return Formatter.currency.string(from: NSNumber(value: 0))
        } else {
            return Formatter.currency.string(from: NSNumber(value: (Double(self) ?? 0) / 100))
        }
    }
}


