// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

class PlayerViewController: UIViewController {
    
    let visualEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blur)
        
        return visualEffectView
    }()
    
    let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    let titleLabel = Label()
    
    let playButton: UIButton = {
        let button = UIButton()
        let playIcon = UIImage(named: "play")
        let stopIcon = UIImage(named: "pause")
        button.setImage(playIcon, for: .normal)
        button.setImage(stopIcon, for: .selected)
        
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        let nextIcon = UIImage(named: "next")
        button.setImage(nextIcon, for: .normal)
        
        return button
    }()
    
    func configure() {
        self.view.isHidden = true
        self.view.addSubviews([visualEffectView, image, titleLabel, playButton, nextButton])
        
        setupLayout()
    }
    
    private func setupLayout() {
        self.visualEffectView.fillSuperview()
        
        self.image.anchor(leading: self.view.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        self.image.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.titleLabel.anchor(leading: image.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
        self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.playButton.anchor(leading: titleLabel.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
        self.playButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.nextButton.anchor(leading: playButton.trailingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 20))
        self.nextButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

}
