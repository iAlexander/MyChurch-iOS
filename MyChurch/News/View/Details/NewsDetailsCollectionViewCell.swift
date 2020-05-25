// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import SwiftSoup

class NewsDetailsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "NewsDetailsCollectionViewCell"
    
    lazy var vm = NewsDetailsViewModel(delegate: self)
    
    let scrollView = ScrollView()
    
    let postImageView = ImageView(cornerRadius: .defaultRadius)
    
    let dateLabel = Label()
    let titleLabel = Label()
    let textLabel = Label()
    
    func configureWithData(data: Article) {
        print("!!! data = \(data)")
        
        self.addSubview(self.scrollView)
        self.scrollView.addSubviews([self.postImageView, self.dateLabel, self.titleLabel, self.textLabel])
        
        if let image = data.image {
            let apiUrl = API.stage.rawValue.correctPath()
            let imageUrl: String = apiUrl + image.path + "/" + image.name
            self.postImageView.imageFromServerURL(imageUrl, placeHolder: nil)
        }
        
        if let date = data.date {
            let formattedDate = date.formatDate(from: .unformatted, to: .dayMonthYearHoursMinutesShort)
            if let formattedDate = formattedDate {
                self.dateLabel.setValue(formattedDate, size: 14, lineHeight: 1.4, fontWeight: .regular, numberOfLines: 1, color: .lightGrayCustom)
            }
        }
        
        if let title = data.title {
            self.titleLabel.setValue(title, size: 22, fontWeight: .bold, numberOfLines: 0, color: .black)
        }
        
        if let text = data.text {
            let formattedText = self.vm.format(text)
            self.textLabel.setValue("", size: 20, fontWeight: .regular, numberOfLines: 0, color: .black)
            self.textLabel.attributedText = formattedText.htmlToAttributedString
        }
        
        setupLayout()
    }
    
    private func setupLayout() {
        self.scrollView.fillSuperview()
        
        self.postImageView.anchor(top: self.scrollView.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: UIScreen.main.bounds.height / 2))
        
        self.dateLabel.anchor(top: self.postImageView.bottomAnchor, leading: self.leadingAnchor,  trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: 17))
        
        self.titleLabel.anchor(top: self.dateLabel.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        self.textLabel.anchor(top: self.titleLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.scrollView.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 24, left: 16, bottom: 16, right: 16))
    }
    
}

extension NewsDetailsCollectionViewCell: NewsDetailsDelegate {
    
    func didParsingHTML(_ data: [Element]) {
        for element in data {
            let string = element.data()
            self.textLabel.setAttributedText(string)
            
            //            let textView = UITextView()
            //            textView.setText
            //            let string =
        }
    }
    
}
