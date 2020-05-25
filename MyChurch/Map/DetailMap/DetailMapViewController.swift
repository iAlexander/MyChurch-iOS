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
    var templeInfo = Temple(id: 0, name: "", lt: 0, lg: 0, locality: "")
    var templeData : TempleData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        self.mainView.createRouteButton.addTarget(self, action: #selector(self.createRoutePressed), for: .touchUpInside)
        GetTempleData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.tintColor = .white
    }
    
    func GetTempleData() {
        getDetailTemple(id:templeInfo.id) { (result) in
            switch result {
            case .success(let data):
                self.templeData = data
                ANLoader.hide()
                self.mainView.churchTopName.text = data.data?.name
                if data.data?.priest?.name == "(вакантна)" || data.data?.priest?.name == nil  {
                    self.mainView.deaneryApiText.isHidden = true
                    self.mainView.deanery.isHidden = true
                } else {
                    self.mainView.deaneryApiText.text = data.data?.priest?.name
                }
                
                if  data.data?.galaDayTitle == "" {
                    self.mainView.templeHolidayApiText.isHidden = true
                    self.mainView.templeHoliday.isHidden = true
                } else {
                    var month = String()
                    var dateStr = data.data?.galaDay?.description
                    dateStr = String(dateStr!.dropFirst(8))
                    dateStr = dateStr!.strstr(needle: "T", beforeNeedle: true) ?? ""
                    if dateStr!.prefix(1) == "0" {
                        dateStr = String(dateStr!.dropFirst(1))
                    }
                    month = String(data.data?.galaDay?.description.dropFirst(5) ?? "")
                    month = month.strstr(needle: "-", beforeNeedle: true) ?? ""
                    if month.prefix(1) == "0" {
                        month = String(month.dropFirst(1))
                    }
                    
                    switch month {
                    case "1": month = "ciчня"
                    case "2":month = "лютого"
                    case "3":month = "березня"
                    case "4":month = "квiтня"
                    case "5":month = "травня"
                    case "6":month = "червня"
                    case "7":month = "липня"
                    case "8":month = "серпня"
                    case "9":month = "вересня"
                    case "10":month = "жовтня"
                    case "11":month = "листопада"
                    case "12":month = "грудня"
                    default:  break
                    }
                    self.mainView.templeHolidayApiText.text = "\(dateStr ?? "") \(month ?? "")"
                }
                
                if data.data?.phone == nil {
                    self.mainView.telApiText.isHidden = true
                    self.mainView.telText.isHidden = true
                } else {
                    self.mainView.telApiText.text = data.data?.phone
                }
                
                if data.data?.presiding?.name == "(вакантна)" {
                    self.mainView.fatherManName.isHidden =  true
                    self.mainView.fatherManNameNeedHidden = true
                    self.mainView.layoutSubviews()
                } else {
                    self.mainView.fatherManNameApiText.text =  data.data?.presiding?.name
                }
                
                self.mainView.adressText.text = "\(data.data?.locality ?? ""), \(data.data?.district ?? ""), \(data.data?.street ?? "")"
                self.mainView.monFriday.text = data.data?.schedule ?? ""
                self.mainView.eparhiyaCityName.text = data.data?.diocese?.name ?? ""
                
                
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
