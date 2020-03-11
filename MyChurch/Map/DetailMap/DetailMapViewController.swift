//
//  DetailMapViewController.swift
//  MyChurch
//
//  Created by Zhekon on 09.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit
import ANLoader

class DetailMapViewController: UIViewController {
    
    let mainView = DetailMapView()
    var templeInfo = Temple(id: 0, name: "", distance: 0, lt: "", lg: "", type: "")
    var templeData : TempleDetailData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        self.mainView.createRouteButton.addTarget(self, action: #selector(self.createRoutePressed), for: .touchUpInside)
        GetTempleData()
        
    }
    
    func GetTempleData() {
        getDetailTemple(id:templeInfo.id) { (result) in
            switch result {
            case .success(let data):
                self.templeData = data
                ANLoader.hide()
                print(self.templeInfo)
                self.mainView.churchTopName.text = data.data?.name
                self.mainView.telApiText.text = data.data?.phone
                self.mainView.fatherManNameApiText.text = data.data?.bishop?.name
                self.mainView.deaneryApiText.text = data.data?.presiding?.name
                self.mainView.adressText.text = "\(data.data?.churchgeo?.locality ?? ""), \(data.data?.churchgeo?.street ?? "")"
                self.mainView.monFriday.text = data.data?.workSchedule?.schedule ?? ""
                self.mainView.eparhiyaCityName.text = data.data?.dioceseType?.type
            case .partialSuccess( _): break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @ objc func createRoutePressed() {
        if (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:
                "comgooglemaps://" + "?daddr=\(Double(templeInfo.lt) ?? 0.0),\(Double(templeInfo.lg) ?? 0.0)&zoom=12&directionsmode=walking")!)
        } else {
            let alertController = UIAlertController(title: "Повiдомлення", message: "Встановiть будь ласка додаток 'Google Map'", preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "закрити", style: .cancel) { (action:UIAlertAction) in
            }
            alertController.addAction(actionCancel)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Храм"
    }
}