// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import AVFoundation

class PrayerDetailsViewController: UIViewController {
    
    convenience init(data: Prayer, player: AVAudioPlayer? = nil) {
        self.init()
        
        self.data = data
//        self.player = player
    }
    
    var data: Prayer?
//    var isAudioPlaying = false
    
//    var player: AVAudioPlayer?
    
    let scrollView = ScrollView()
    
    
    let dismissLabel: Button = {
        let button = Button("Повернутися", fontSize: 14, fontColor: .lightGrayCustom)
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        
        return button
    }()
    let dismissButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "arrow-down")
        let imageTint = UIImage(named: "arrow-down")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.setImage(imageTint, for: .highlighted)
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        
        return button
    }()
    
    let playerView = PlayerDetailsView()
    
    let titleLabel = Label()
    let textLabel = Label()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if #available(iOS 13.0, *) {
            self.view.addSubviews([self.scrollView, self.dismissButton])
        } else {
            self.view.addSubviews([self.scrollView, self.dismissLabel, self.dismissButton])
        }
        self.scrollView.addSubviews([self.titleLabel, self.textLabel])
        
        if let title = self.data?.title {
            self.titleLabel.setValue(title, size: 16, fontWeight: .bold, numberOfLines: 0, color: .black)
        }
        
        if let text = self.data?.text {
            self.textLabel.setValue(text, size: 16, fontWeight: .regular, numberOfLines: 0, color: .black)
//            self.textLabel.attributedText = text.htmlToAttributedString
        }
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Do any additional setup before appearing the view.
        
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .white
        
        self.scrollView.fillSuperview()
        
        if #available(iOS 13.0, *) {
            self.dismissButton.anchor(top: self.view.topAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 16))
            self.titleLabel.anchor(top: self.scrollView.topAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 40, left: 16, bottom: 16, right: 16))
        } else {
            // Fallback on earlier versions
            self.dismissButton.anchor(top: self.view.topAnchor, padding: UIEdgeInsets(top: 48, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 16))
            self.dismissLabel.anchor(leading: self.view.leadingAnchor, bottom: self.dismissButton.topAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            self.titleLabel.anchor(top: self.scrollView.topAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 80, left: 16, bottom: 16, right: 16))
        }
        self.dismissButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.textLabel.anchor(top: self.titleLabel.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.scrollView.bottomAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 24, left: 16, bottom: 16, right: 16))
    }
    
}

extension PrayerDetailsViewController {
    
    @objc func dismissViewController(_ sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
