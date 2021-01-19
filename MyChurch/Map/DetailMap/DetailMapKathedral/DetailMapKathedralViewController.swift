//
//  DetailMapKathedralViewController.swift
//  MyChurch
//
//  Created by Zhekon on 10.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit
import ANLoader

class DetailMapKathedralViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let mainView = DetailMapKathedralView()
    var templeInfo = Temple(id: 0, name: "", lt: 0, lg: 0, locality: "")
    var templeData : TempleData?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
            ANLoader.hide()
            switch result {
            case .success(let data):
                self.templeData = data
                if data.data?.files?.isEmpty == false {
                    self.mainView.imageCollectionView.reloadData()
                } else {
                    self.mainView.emptyImage = true
                }
                if data.data?.galaDayTitle == "" || data.data?.galaDayTitle == nil {
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
                if let history = data.data?.history {
                    let titleFont: UIFont = .systemFont(ofSize: 18, weight: .semibold)
                    let textFont: UIFont = .systemFont(ofSize: 18, weight: .regular)
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineHeightMultiple = 1.26
                    let attributtedHistory = NSMutableAttributedString(string: "Опис та історія\n", attributes: [NSAttributedString.Key.font: titleFont, NSAttributedString.Key.paragraphStyle: paragraphStyle])
                    attributtedHistory.append(NSAttributedString(string: history, attributes: [NSAttributedString.Key.font: textFont, NSAttributedString.Key.paragraphStyle: paragraphStyle]))
                    self.mainView.hramHistory.attributedText = attributtedHistory
                }
                self.mainView.churchTopName.text = data.data?.name
                var addressText = ""
                if let locality = data.data?.locality {
                    addressText.append(locality)
                }
                if let district = data.data?.district {
                    addressText.append(", " + district)
                }
                if let street = data.data?.street {
                    addressText.append(", " + street)
                }
                self.mainView.adressText.text = addressText
                self.mainView.monFriday.text = data.data?.schedule ?? ""
                self.mainView.eparhiyaCityName.text =  data.data?.diocese?.name ?? ""
                self.mainView.setNeedsLayout()
                UIView.animate(withDuration: 0.4) {
                    self.mainView.scrollView.alpha = 1
                }
            case .partialSuccess( _): break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureHiddenLabels() {
        if templeData?.data?.galaDayTitle == "" {
            self.mainView.templeHolidayApiText.isHidden = true
            self.mainView.templeHoliday.isHidden = true
        } else {
            self.mainView.templeHolidayApiText.isHidden = false
            self.mainView.templeHoliday.isHidden = false
        }
        if templeData?.data?.phone == "" || templeData?.data?.phone == nil {
            self.mainView.telApiText.isHidden = true
            self.mainView.telText.isHidden = true
        } else {
            self.mainView.telApiText.isHidden = false
            self.mainView.telText.isHidden = false
        }
        if templeData?.data?.presiding?.name == "" || templeData?.data?.presiding?.name == nil || templeData?.data?.presiding?.name == "(вакантна)" {
            self.mainView.fatherManNameApiText.isHidden = true
            self.mainView.fatherManName.isHidden = true
        } else {
            self.mainView.fatherManNameApiText.isHidden = false
            self.mainView.fatherManName.isHidden = false
        }
        if templeData?.data?.priest?.name == "" || templeData?.data?.priest?.name == nil || templeData?.data?.priest?.name == "(вакантна)" {
            self.mainView.deaneryApiText.isHidden = true
            self.mainView.deanery.isHidden = true
        } else {
            self.mainView.deaneryApiText.isHidden = false
            self.mainView.deanery.isHidden = false
        }
    }
    
    @objc func createRoutePressed() {
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
        case 0: mainView.openNow.isHidden = false;mainView.pointText.isHidden = false; mainView.closeAtTop.isHidden = false;mainView.workScheduleText.isHidden = false;mainView.monFriday.isHidden = false;  mainView.markerImage.isHidden = false; mainView.adressText.isHidden = false;mainView.createRouteView.isHidden = false;mainView.templeHoliday.isHidden = false;mainView.fatherManName.isHidden = false; mainView.telText.isHidden = false;mainView.templeHolidayApiText.isHidden = false;mainView.fatherManNameApiText.isHidden = false;  mainView.telApiText.isHidden = false;mainView.hramHistory.isHidden = true;
            self.configureHiddenLabels()
            mainView.layoutSubviews()
        case 1: mainView.openNow.isHidden = true;   mainView.pointText.isHidden = true;
        mainView.closeAtTop.isHidden = true;  mainView.workScheduleText.isHidden = true;  mainView.monFriday.isHidden = true;  mainView.markerImage.isHidden = true;
        mainView.adressText.isHidden = true;   mainView.createRouteView.isHidden = true;  mainView.templeHoliday.isHidden = true;  mainView.fatherManName.isHidden = true;
            mainView.deanery.isHidden = true;  mainView.telText.isHidden = true;  mainView.templeHolidayApiText.isHidden = true;  mainView.fatherManNameApiText.isHidden = true;mainView.deaneryApiText.isHidden = true;  mainView.telApiText.isHidden = true; mainView.hramHistory.isHidden = false;  mainView.layoutSubviews()
        default:
            break
        }
    }
    
    
    func ConfigView() {
//        self.view.addSubview(mainView)
//        self.mainView.frame = self.view.bounds
        self.view = mainView
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Храм"
        mainView.infoSegmentControll.selectedSegmentIndex = 0
        mainView.imageCollectionView.delegate = self
        mainView.imageCollectionView.dataSource = self
        mainView.imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
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
        return templeData?.data?.files?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if templeData?.data?.files?.count == 1 {
            return CGSize(width: UIScreen.main.bounds.size.width - 32, height: 240)
        } else {
            return CGSize(width: UIScreen.main.bounds.size.width - 55, height: 240)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        let urlString = "http://test.cerkva.asp-win.d2.digital/\(templeData?.data?.files?[indexPath.row].file.file?.path ?? "")/\(templeData?.data?.files?[indexPath.row].file.file?.name ?? "")"
        if let imageUrl = URL(string: urlString) {
            cell.image.load(url: imageUrl)
        }
        return cell
    }
}

