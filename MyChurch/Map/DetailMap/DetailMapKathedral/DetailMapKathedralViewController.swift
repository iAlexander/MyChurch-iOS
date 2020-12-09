//
//  DetailMapKathedralViewController.swift
//  MyChurch
//
//  Created by Zhekon on 10.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit
import ANLoader

class DetailMapKathedralViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let mainView = DetailMapKathedralView()
    var templeInfo = Temple(id: 0, name: "", lt: 0, lg: 0, locality: "")
    var templeData : TempleData?
    private let reuseIdentifierCollectionView = "imageCell"
    var imageUrlString = String()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.hramHistory.isHidden = true
        ConfigView()
        self.mainView.createRouteButton.addTarget(self, action: #selector(self.createRoutePressed), for: .touchUpInside)
        GetTempleData()
        mainView.infoSegmentControll.addTarget(self, action: #selector(segmentedPressed), for: .valueChanged)
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
                if data.data?.files?.count ?? 0 > 0 {
                    self.imageUrlString = "https://mobile.pomisna.info/\(data.data?.files?[0].file.file?.path ?? "")/\(data.data?.files?[0].file.file?.name ?? "")"
                    let imageUrl = URL(string: self.imageUrlString)!
                    self.mainView.imageCollectionView.load(url: imageUrl)
                } else {
                    self.mainView.emptyImage = true
                    self.mainView.layoutSubviews()
                }
                ANLoader.hide()
                var month = String()
                var dateStr =   self.templeData?.data?.galaDay?.description
                dateStr = String(dateStr!.dropFirst(8))
                dateStr = dateStr!.strstr(needle: "T", beforeNeedle: true) ?? ""
                if dateStr!.prefix(1) == "0" {
                    dateStr = String(dateStr!.dropFirst(1))
                }
                month = String(  self.templeData?.data?.galaDay?.description.dropFirst(5) ?? "")
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
                self.mainView.templeHolidayApiText.text = "\(dateStr ?? "") \(month)"
                if data.data?.phone == "" || data.data?.phone == nil {
                    self.mainView.telApiText.isHidden = true
                    self.mainView.telText.isHidden = true
                } else {
                    self.mainView.telApiText.text = data.data?.phone
                }
                if data.data?.presiding?.name == "" || data.data?.presiding?.name == nil || data.data?.presiding?.name == "(вакантна)" {
                    self.mainView.fatherManNameApiText.isHidden = true
                    self.mainView.fatherManName.isHidden = true
                } else {
                    self.mainView.fatherManNameApiText.text = data.data?.presiding?.name
                }
                
                if data.data?.priest?.name == "" || data.data?.priest?.name == nil || data.data?.priest?.name == "(вакантна)" {
                    self.mainView.deaneryApiText.isHidden = true
                    self.mainView.deanery.isHidden = true
                } else {
                    self.mainView.deaneryApiText.text = data.data?.priest?.name
                }
                self.mainView.hramHistory.text = data.data?.history
                self.mainView.churchTopName.text = data.data?.name
                self.mainView.adressText.text = "\(data.data?.locality ?? ""), \(data.data?.district ?? ""), \(data.data?.street ?? "")"
                self.mainView.monFriday.text = data.data?.schedule ?? ""
                self.mainView.eparhiyaCityName.text =  data.data?.diocese?.name ?? ""
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
    
    // MARK: Work targets
    @objc func segmentedPressed() {
        switch mainView.infoSegmentControll.selectedSegmentIndex
        {
        case 0: mainView.openNow.isHidden = false;mainView.pointText.isHidden = false; mainView.closeAtTop.isHidden = false;mainView.workScheduleText.isHidden = false;mainView.monFriday.isHidden = false;  mainView.markerImage.isHidden = false; mainView.adressText.isHidden = false;mainView.createRouteView.isHidden = false;mainView.templeHoliday.isHidden = false;mainView.fatherManName.isHidden = false; mainView.deanery.isHidden = false;mainView.telText.isHidden = false;mainView.templeHolidayApiText.isHidden = false;mainView.fatherManNameApiText.isHidden = false;mainView.deaneryApiText.isHidden = false;  mainView.telApiText.isHidden = false;mainView.layoutSubviews(); mainView.eparhiyaCityName.text = self.templeData?.data?.diocese?.name;mainView.hramHistory.isHidden = true;
        case 1: mainView.openNow.isHidden = true;   mainView.pointText.isHidden = true;
        mainView.closeAtTop.isHidden = true;  mainView.workScheduleText.isHidden = true;  mainView.monFriday.isHidden = true;  mainView.markerImage.isHidden = true;
        mainView.adressText.isHidden = true;   mainView.createRouteView.isHidden = true;  mainView.templeHoliday.isHidden = true;  mainView.fatherManName.isHidden = true;
        mainView.deanery.isHidden = true;  mainView.telText.isHidden = true;  mainView.templeHolidayApiText.isHidden = true;  mainView.fatherManNameApiText.isHidden = true;mainView.deaneryApiText.isHidden = true;  mainView.telApiText.isHidden = true; mainView.eparhiyaCityName.text = "Опис та історія"; mainView.hramHistory.isHidden = false;  mainView.layoutSubviews()
        default:
            break
        }
    }
    
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Храм"
        mainView.infoSegmentControll.selectedSegmentIndex = 0
        
        if #available(iOS 13.0, *) {
            mainView.infoSegmentControll.backgroundColor = .white
            mainView.infoSegmentControll.selectedSegmentTintColor =  UIColor(red: 0.008, green: 0.529, blue: 0.918, alpha: 1)
            mainView.infoSegmentControll.layer.borderColor = UIColor(red: 0.008, green: 0.529, blue: 0.918, alpha: 1).cgColor
            mainView.infoSegmentControll.layer.borderWidth = 1
            
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor:  UIColor(red: 0.008, green: 0.529, blue: 0.918, alpha: 1)]
            mainView.infoSegmentControll.setTitleTextAttributes(titleTextAttributes, for:.normal)
            
            let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
            mainView.infoSegmentControll.setTitleTextAttributes(titleTextAttributes1, for:.selected)
        } else {
            // Fallback on earlier versions
        }
    }
    
    //MARK: work with collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCollectionView, for: indexPath) as! HolidayImageCollectionCell
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 10
        return cell
    }
}

