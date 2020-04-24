// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import AVKit
import AVFoundation

class PrayerDetailsViewController: UIViewController {
    
    convenience init(data: Prayer) {
        self.init()
        
        self.data = data
    }
    
    var isAudioPlaying = false
    
    var data: Prayer?
    
    var player: AVAudioPlayer!
    
    override func loadView() {
        super.loadView()
        
        // Do any additional setup before loading the view.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Do any additional setup before appearing the view.
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .white
    }
    
}

extension PrayerDetailsViewController {
    
    @objc func dismissViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
