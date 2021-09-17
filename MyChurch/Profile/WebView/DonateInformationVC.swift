//
//  DonateInformationVC.swift
//  DonateInformationVC
//
//  Created by Taras Tanskiy on 07.09.2021.
//  Copyright © 2021 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class DonateInformationVC: UIViewController {
    
    let mainView = DonateInformationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        mainView.donateButton.addTarget(self, action: #selector(suppPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "Благодійність"
    }
    
    @objc func suppPressed() {
        sendLikPayData(value: "paydonate") { (result) in
            switch result {
            case .success(let data):
                if data.ok ?? false {
                    let vc = WebViewController()
                    vc.title = "Благодійність"
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
    
    func ConfigView() {
        self.view = mainView
    }
}
