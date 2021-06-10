// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import SwiftSoup

class NewsDetailsCollectionViewCell: UICollectionViewCell, UITextViewDelegate {
    
    static let reuseIdentifier = "NewsDetailsCollectionViewCell"
    
    lazy var vm = NewsDetailsViewModel(delegate: self)
    
    let scrollView = ScrollView()
    
    let postImageView = ScaledHeightImageView()
    
    let dateLabel = Label()
    let titleLabel = Label()
    let textView = UITextView()
    
    func configureWithData(data: Article) {
        print("!!! data = \(data)")
        
        self.addSubview(self.scrollView)
        self.scrollView.addSubviews([self.postImageView, self.dateLabel, self.titleLabel, self.textView])
        
        if let image = data.image {
            postImageView.contentMode = .scaleAspectFit
            let apiUrl = API.stage.rawValue.correctPath()
            let imageUrl: String = apiUrl + image.path + "/" + image.name
            if let url = URL(string: imageUrl) {
                self.postImageView.load(url: url)
            }
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
            textView.delegate = self
            textView.translatesAutoresizingMaskIntoConstraints = true
            textView.sizeToFit()
            textView.isScrollEnabled = false
            textView.isUserInteractionEnabled = true
            textView.isEditable = false
            textView.isSelectable = true
            textView.dataDetectorTypes = [.link]
            textView.font = .systemFont(ofSize: 20, weight: .regular)
            textView.attributedText = formattedText.htmlToAttributedString
        }
        
        setupLayout()
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
    private func setupLayout() {
        self.scrollView.fillSuperview()
        self.postImageView.anchor(top: self.scrollView.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        
        self.dateLabel.anchor(top: self.postImageView.bottomAnchor, leading: self.leadingAnchor,  trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: 17))
        
        self.titleLabel.anchor(top: self.dateLabel.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        self.textView.anchor(top: self.titleLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.scrollView.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 24, left: 16, bottom: 16, right: 16))
    }
    
}

extension NewsDetailsCollectionViewCell: NewsDetailsDelegate {
    
    func didParsingHTML(_ data: [Element]) {
//        for element in data {
//            let string = element.data()
//            self.textLabel.setAttributedText(string)
//        }
    }
    
}

class ScaledHeightImageView: UIImageView {

    private var layoutedWidth: CGFloat = 0

        override var intrinsicContentSize: CGSize {
            layoutedWidth = bounds.width
            if let image = self.image {
                let viewWidth = bounds.width
                let ratio = viewWidth / image.size.width
                return CGSize(width: viewWidth, height: image.size.height * ratio)
            }
            return super.intrinsicContentSize
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            if layoutedWidth != bounds.width {
                invalidateIntrinsicContentSize()
            }
        }

}
