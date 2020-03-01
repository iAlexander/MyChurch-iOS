//
//  DetailHolidayViewController.swift
//  MyChurch
//
//  Created by Zhekon on 26.02.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class DetailHolidayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let mainView = DetailHolidayView()
    private let reuseIdentifierCollectionView = "imageCell"
    var titleText = String()
    var holidayId = Int()
    var detailHolidayInfo: HolidayData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        getDetailHolidays(id: holidayId) { (result) in
            switch result {
            case .success(let data):
                self.detailHolidayInfo = data.data
                let clearTextString =  self.detailHolidayInfo?.describe?.slice(from: "<b>", to:  "</b>")
                self.mainView.holidayTextView.text = "\(clearTextString ?? "")\n\(self.detailHolidayInfo?.conceived ?? "")"
                self.mainView.holidayTopName.text = self.detailHolidayInfo?.name
                self.mainView.holidayTopInfo.text = self.detailHolidayInfo?.groupId?.name
                var dateTextAll = String()
                var oldDate =  self.detailHolidayInfo?.dateOldStyle?.strstr(needle: "T", beforeNeedle: true)
                oldDate = oldDate?.dropFirst(5).description
                let dayFirst = oldDate?.strstr(needle: "-", beforeNeedle: false)
                switch  oldDate?.prefix(2) {
                case "01": dateTextAll = "\(dayFirst ?? "") ciчня"
                case "02": dateTextAll = "\(dayFirst ?? "") лютого"
                case "03": dateTextAll = "\(dayFirst ?? "") березня"
                case "04": dateTextAll = "\(dayFirst ?? "") квiтня"
                case "05": dateTextAll = "\(dayFirst ?? "") травня"
                case "06": dateTextAll = "\(dayFirst ?? "") червня"
                case "07": dateTextAll = "\(dayFirst ?? "") липня"
                case "08": dateTextAll = "\(dayFirst ?? "") серпня"
                case "09": dateTextAll = "\(dayFirst ?? "") вересня"
                case "10": dateTextAll = "\(dayFirst ?? "") жовтня"
                case "11": dateTextAll = "\(dayFirst ?? "") листопада"
                case "12": dateTextAll = "\(dayFirst ?? "") грудня"
                default: break
                }
                
                var newDate = self.detailHolidayInfo?.dateNewStyle?.strstr(needle: "T", beforeNeedle: true)
                newDate = newDate?.dropFirst(5).description
                let daySecond = newDate?.strstr(needle: "-", beforeNeedle: false)
                switch  newDate?.prefix(2) {
                case "01": dateTextAll += "(\(daySecond ?? "") ciчня за старим календарем)"
                case "02": dateTextAll += "(\(daySecond ?? "") лютого за старим календарем)"
                case "03": dateTextAll += "(\(daySecond ?? "") березня за старим календарем)"
                case "04": dateTextAll += "(\(daySecond ?? "") квiтня за старим календарем)"
                case "05": dateTextAll += "(\(daySecond ?? "") травня за старим календарем)"
                case "06": dateTextAll += "(\(daySecond ?? "") червня за старим календарем)"
                case "07": dateTextAll += "(\(daySecond ?? "") липня за старим календарем)"
                case "08": dateTextAll += "(\(daySecond ?? "") серпня за старим календарем)"
                case "09": dateTextAll += "(\(daySecond ?? "") вересня за старим календарем)"
                case "10": dateTextAll += "(\(daySecond ?? "") жовтня за старим календарем)"
                case "11": dateTextAll += "(\(daySecond ?? "") листопада за старим календарем)"
                case "12": dateTextAll += "(\(daySecond ?? "") грудня за старим календарем)"
                default: break
                }
                self.mainView.holidayTopDate.text = dateTextAll
            case .partialSuccess( _): break
            case .failure(let error):
                print(error)
            }
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
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.title = titleText
        mainView.imageCollectionView!.delegate = self
        mainView.imageCollectionView!.dataSource = self
        mainView.imageCollectionView!.showsHorizontalScrollIndicator = false
        mainView.imageCollectionView!.register(HolidayImageCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifierCollectionView)
    }
}

extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
}
