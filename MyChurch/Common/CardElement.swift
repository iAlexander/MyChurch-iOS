// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

class CardElement: UIView {
    
    convenience init(title: String, imageUrl: String = "", leftSubtitle: String = "", centerSubtitle: String = "", rightSubtitle: String = "") {
        self.init()
        
        setValue(title: title, imageUrl: imageUrl, leftSubtitle: leftSubtitle, centerSubtitle: centerSubtitle, rightSubtitle: rightSubtitle)
    }
    
    let contentView = UIView()
    
    let titleLabel = Label()
    let imageView = UIImageView()
    let leftSubtitleLabel = Label()
    let centerSubtitleLabel = Label()
    let rightSubtitleLabel = Label()
    
    func setValue(title: String, imageUrl: String = "", leftSubtitle: String = "", centerSubtitle: String = "", rightSubtitle: String = "") {
        self.addSubview(self.contentView)
        self.contentView.addSubviews([self.titleLabel, self.imageView, self.leftSubtitleLabel, self.centerSubtitleLabel, self.rightSubtitleLabel])
        
        self.imageView.imageFromServerURL(imageUrl, placeHolder: #imageLiteral(resourceName: "map-tint"))
        
        
        self.leftSubtitleLabel.setValue(leftSubtitle, size: 12, lineHeight: 1.4, fontWeight: .regular, numberOfLines: 1, color: .lightGrayCustom)
        self.centerSubtitleLabel.setValue(centerSubtitle, size: 12, lineHeight: 1.4, fontWeight: .regular, numberOfLines: 1, color: .lightGrayCustom)
        self.rightSubtitleLabel.setValue(rightSubtitle, size: 12, lineHeight: 1.4, fontWeight: .regular, numberOfLines: 1, color: .lightGrayCustom, textAlignment: .right)
        
        self.titleLabel.setValue(title, size: 16, fontWeight: .bold, numberOfLines: 3, color: .black)
        
        setupLayout()
    }
    
    private func setupLayout() {
        self.contentView.fillSuperview(padding: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16))
        let cardElementWidth = UIDevice.resolution.width - 32
        
        self.imageView.anchor(top: self.contentView.topAnchor, leading: self.contentView.leadingAnchor, bottom: self.contentView.bottomAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0), size: CGSize(width: 88, height: 88))
        
        self.leftSubtitleLabel.anchor(top: self.contentView.topAnchor, leading: self.imageView.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0))
        self.leftSubtitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: (cardElementWidth - 32) / 3).isActive = true
        
        self.centerSubtitleLabel.anchor(top: self.contentView.topAnchor, leading: self.leftSubtitleLabel.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 0))
        self.centerSubtitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: (cardElementWidth - 32) / 3).isActive = true
        
        self.rightSubtitleLabel.anchor(top: self.contentView.topAnchor, leading: self.centerSubtitleLabel.trailingAnchor, trailing: self.contentView.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 16))
        self.rightSubtitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: (cardElementWidth - 32) / 3).isActive = true
        
        self.titleLabel.anchor(top: self.leftSubtitleLabel.bottomAnchor, leading: self.imageView.leadingAnchor, bottom: self.contentView.bottomAnchor, trailing: self.contentView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16))
        
        self.contentView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
}
