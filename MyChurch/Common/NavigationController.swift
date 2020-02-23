// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

enum ButtonsType {
    case search
    case notification
}

struct NavigationBarConfig {
    let title: String?
    let buttons: [ButtonsType]
}

protocol NavigationDelegate: class {
    func openViewController(_ vc: ViewController)
    func setBackButtonTitle(_ text: String)
}

class NavigationViewController: UINavigationController {
    
    // This element should overlap default NavBar's border & shadows
    let border = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationBar.isTranslucent = false
        self.navigationBar.addSubview(self.border)
        
        let gradient = CAGradientLayer()
        var bounds = navigationBar.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        
        gradient.colors = [
            UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1).cgColor,
            UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1).cgColor
        ]
        
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        if let image = getImageFrom(gradientLayer: gradient) {
            navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        }
        
        setupLayout()
    }
    
    private func setupLayout() {
        self.border.backgroundColor = .white
        
        self.border.anchor(top: self.navigationBar.bottomAnchor, leading: self.navigationBar.leadingAnchor, trailing: self.navigationBar.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
    }
    
}

extension NavigationViewController: NavigationDelegate {
    
    func openViewController(_ vc: ViewController) {
        self.pushViewController(vc, animated: true)
    }
    
    func setBackButtonTitle(_ title: String) {
        self.isNavigationBarHidden = false
        
        let backItem = UIBarButtonItem()
        backItem.title = title
        
        self.navigationItem.backBarButtonItem = backItem
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
}
