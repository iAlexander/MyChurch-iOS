// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import SwiftSoup

class NewsDetailsCollectionViewCell: UICollectionViewCell, UITextViewDelegate {
    
    static let reuseIdentifier = "NewsDetailsCollectionViewCell"
    
    lazy var vm = NewsDetailsViewModel(delegate: self)
    
    let scrollView = ScrollView()
    
    let postImageView = ScaledHeightImageView()
    
    let titleLabel = Label()
    let textView = UITextView()
    
    func configureWithData(data: NewsWordPressModel) {
//        print("!!! data = \(data)")
        
        self.addSubview(self.scrollView)
        self.scrollView.addSubviews([self.postImageView, self.titleLabel, self.textView])
        
        if let url = URL(string: "https://www.pomisna.info/uk/wp-json/wp/v2/media/\(data.featured_media!)") {
            self.postImageView.loadNewsImage(url: url, size: .full, index: postImageView.tag)
        }
        
        if let title = data.title?.rendered?.htmlToString {
            self.titleLabel.setValue(title, size: 22, fontWeight: .bold, numberOfLines: 0, color: .black)
        }
        
        if let text = data.content?.rendered {
            textView.delegate = self
            textView.translatesAutoresizingMaskIntoConstraints = true
            textView.sizeToFit()
            textView.isScrollEnabled = false
            textView.isUserInteractionEnabled = true
            textView.isEditable = false
            textView.isSelectable = true
            textView.dataDetectorTypes = [.link]
            let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(18)\">%@</span>", text)
            textView.attributedText = modifiedFont.htmlToAttributedString
        }
        
        setupLayout()
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.sd_cancelCurrentImageLoad()
        self.postImageView.image = nil
    }
    
    private func setupLayout() {
        self.scrollView.fillSuperview()
        self.postImageView.anchor(top: self.scrollView.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        
        self.titleLabel.anchor(top: self.postImageView.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
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
