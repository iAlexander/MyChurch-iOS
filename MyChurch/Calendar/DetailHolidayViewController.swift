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
        let data = Data(self.detailHolidayInfo!.describe!.utf8)
        if let attributedString = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil), let conceived = self.detailHolidayInfo?.conceived {
            attributedString.append(NSAttributedString(string: "\n\(conceived)"))
            let font = UIFont.systemFont(ofSize: 18, weight: .regular)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.26
            attributedString.addAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            self.mainView.holidayTextLabel.attributedText = attributedString
        }
        
        if !imageUrlString.isEmpty {
        let imageUrl = URL(string: imageUrlString)!
        self.mainView.imageView.load(url: imageUrl)
            mainView.imageIsEmpty = false
            mainView.layoutSubviews()
        }
        self.mainView.holidayTopName.text = self.detailHolidayInfo?.name
        self.mainView.holidayTopInfo.text = self.detailHolidayInfo?.fasting == 1 ? "Пiсний день" : "Посту немає"
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
        case "01": dateTextAll += " (\(dayFirst ?? "") ciчня за старим стилем)"
        case "02": dateTextAll += " (\(dayFirst ?? "") лютого за старим стилем)"
        case "03": dateTextAll += " (\(dayFirst ?? "") березня за старим стилем)"
        case "04": dateTextAll += " (\(dayFirst ?? "") квiтня за старим стилем)"
        case "05": dateTextAll += " (\(dayFirst ?? "") травня за старим стилем)"
        case "06": dateTextAll += " (\(dayFirst ?? "") червня за старим стилем)"
        case "07": dateTextAll += " (\(dayFirst ?? "") липня за старим стилем)"
        case "08": dateTextAll += " (\(dayFirst ?? "") серпня за старим стилем)"
        case "09": dateTextAll += " (\(dayFirst ?? "") вересня за старим стилем)"
        case "10": dateTextAll += " (\(dayFirst ?? "") жовтня за старим стилем)"
        case "11": dateTextAll += " (\(dayFirst ?? "") листопада за старим стилем)"
        case "12": dateTextAll += " (\(dayFirst ?? "") грудня за старим стилем)"
        default: break
        }
        self.mainView.holidayTopDate.text = dateTextAll
        if let color = detailHolidayInfo?.color {
            mainView.goldenView.backgroundColor = UIColor(hexString: color)
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
//        self.view.addSubview(mainView)
//        self.mainView.frame = self.view.bounds
        self.view = mainView
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

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
