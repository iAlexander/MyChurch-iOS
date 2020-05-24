// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

class PrayerDetailsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = {
        return String(describing: self)
    }()
    
    let scrollView = ScrollView()
    
    let titleLabel = Label()
    let textLabel = Label()
    
    func configureWithData(data: Prayer) {
        self.addSubview(self.scrollView)
        self.scrollView.addSubviews([self.titleLabel, self.textLabel])
        
        if let title = data.title {
            self.titleLabel.setValue(title, size: 22, fontWeight: .bold, numberOfLines: 0, color: .black)
        }
        
        if let text = data.text {
            self.textLabel.setValue(text, size: 20, fontWeight: .regular, numberOfLines: 0, color: .black)
        }
        
        setupLayout()
    }
    
    private func setupLayout() {
        self.scrollView.fillSuperview()
        
        self.titleLabel.anchor(top: self.scrollView.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        self.textLabel.anchor(top: self.titleLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.scrollView.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 24, left: 16, bottom: 48, right: 16))
    }
}
