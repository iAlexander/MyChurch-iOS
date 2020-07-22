//
//  DetailHolidayViewController.swift
//  MyChurch
//
//  Created by Zhekon on 26.02.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class DetailHolidayViewController: UIViewController {
    
    let mainView = DetailHolidayView()
    private let reuseIdentifierCollectionView = "imageCell"
    var titleText = String()
    var holidayId = Int()
    var detailHolidayInfo: HolidaysData?
    var imageUrlString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        let clearTextString =  self.detailHolidayInfo?.describe?.slice(from: "<b>", to:  "</b>")
        if !imageUrlString.isEmpty {
        let imageUrl = URL(string: imageUrlString)!
        self.mainView.imageView.load(url: imageUrl)
            mainView.imageIsEmpty = false
            mainView.layoutSubviews()
        }
        self.mainView.holidayTextView.text = "\(clearTextString ?? "")\n\(self.detailHolidayInfo?.conceived ?? "")"
        self.mainView.holidayTopName.text = self.detailHolidayInfo?.name
        self.mainView.holidayTopInfo.text = self.detailHolidayInfo?.group?.name
        var dateTextAll = String()
        
        var newDate = self.detailHolidayInfo?.dateNewStyle
        newDate = newDate?.dropFirst(5).description
        let daySecond = newDate?.strstr(needle: "-", beforeNeedle: false)
        switch  newDate?.prefix(2) {
        case "01": dateTextAll = "\(daySecond ?? "") ciчня"
        case "02": dateTextAll = "\(daySecond ?? "") лютого"
        case "03": dateTextAll = "\(daySecond ?? "") березня"
        case "04": dateTextAll = "\(daySecond ?? "") квiтня"
        case "05": dateTextAll = "\(daySecond ?? "") травня"
        case "06": dateTextAll = "\(daySecond ?? "") червня"
        case "07": dateTextAll = "\(daySecond ?? "") липня"
        case "08": dateTextAll = "\(daySecond ?? "") серпня"
        case "09": dateTextAll = "\(daySecond ?? "") вересня"
        case "10": dateTextAll = "\(daySecond ?? "") жовтня"
        case "11": dateTextAll = "\(daySecond ?? "") листопада"
        case "12": dateTextAll = "\(daySecond ?? "") грудня"
        default: break
        }
        
        var oldDate =  self.detailHolidayInfo?.dateOldStyle?.strstr(needle: "T", beforeNeedle: true)
        oldDate = oldDate?.dropFirst(5).description
        let dayFirst = oldDate?.strstr(needle: "-", beforeNeedle: false)
        switch  oldDate?.prefix(2) {
        case "01": dateTextAll += "(\(dayFirst ?? "") ciчня за старим календарем)"
        case "02": dateTextAll += "(\(dayFirst ?? "") лютого за старим календарем)"
        case "03": dateTextAll += "(\(dayFirst ?? "") березня за старим календарем)"
        case "04": dateTextAll += "(\(dayFirst ?? "") квiтня за старим календарем)"
        case "05": dateTextAll += "(\(dayFirst ?? "") травня за старим календарем)"
        case "06": dateTextAll += "(\(dayFirst ?? "") червня за старим календарем)"
        case "07": dateTextAll += "(\(dayFirst ?? "") липня за старим календарем)"
        case "08": dateTextAll += "(\(dayFirst ?? "") серпня за старим календарем)"
        case "09": dateTextAll += "(\(dayFirst ?? "") вересня за старим календарем)"
        case "10": dateTextAll += "(\(dayFirst ?? "") жовтня за старим календарем)"
        case "11": dateTextAll += "(\(dayFirst ?? "") листопада за старим календарем)"
        case "12": dateTextAll += "(\(dayFirst ?? "") грудня за старим календарем)"
        default: break
        }
        self.mainView.holidayTopDate.text = dateTextAll
        
        switch detailHolidayInfo?.priority {
        case 1: mainView.goldenView.backgroundColor = hexStringToUIColor(hex: "#ffb600")
        case 2: mainView.goldenView.backgroundColor = hexStringToUIColor(hex: "#e5e1t6")
        case 3:mainView.goldenView.backgroundColor = hexStringToUIColor(hex: "#0075c9")
        case 4:mainView.goldenView.backgroundColor = hexStringToUIColor(hex: "#bc2f2c")
        case 5:mainView.goldenView.backgroundColor = hexStringToUIColor(hex: "#d9d8d6")
        case 7:mainView.goldenView.backgroundColor = hexStringToUIColor(hex: "#db0032")
        case 8:mainView.goldenView.backgroundColor = hexStringToUIColor(hex: "#8331a7")
        case 9:mainView.goldenView.backgroundColor = hexStringToUIColor(hex: "#212721")
        default: break
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
       
        self.navigationController!.navigationBar.tintColor = .white
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

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
