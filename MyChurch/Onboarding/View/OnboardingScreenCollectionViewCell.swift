// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

class OnboardingScreenCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = {
        return String(describing: self)
    }()
    
    let imageView: ImageView = {
        let imageView = ImageView(contentMode: .scaleAspectFit, cornerRadius: 0)
        
        return imageView
    }()
    let bgImageView: ImageView = {
        let imageView = ImageView(contentMode: .scaleAspectFit, cornerRadius: 0)
        
        return imageView
    }()
    let descriptionLabel = Label()
    
    func configureWithData(_ image: UIImage, description: String, bgImage: UIImage) {
        self.addSubviews([self.bgImageView, self.imageView, self.descriptionLabel])
        
        self.imageView.image = image
        self.bgImageView.image = bgImage
        self.descriptionLabel.setValue(description, size: 22, fontWeight: .semibold, numberOfLines: 2, textAlignment: .center)
        
        setupLayout()
    }
    
    private func setupLayout() {
        self.backgroundColor = .white
        
        self.bgImageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: self.frame.height - 100))
        self.imageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 48, bottom: 0, right: 48), size: CGSize(width: 0, height: self.frame.height - 100))
        
        self.descriptionLabel.anchor(top: self.imageView.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
    }
    
}
