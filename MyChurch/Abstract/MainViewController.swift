// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

protocol MainViewControllerDelegate {
    var backBarButtonItem: UIBarButtonItem { get set }
    var forwardBarButtonItem: UIBarButtonItem { get set }
    var searchBarButtonItem: UIBarButtonItem { get set }
    var notificationhBarButtonItem: UIBarButtonItem { get set }
    
}

class MainViewController: UIViewController, MainViewControllerDelegate {
    
    lazy var backBarButtonItem: UIBarButtonItem = {
        let icon = #imageLiteral(resourceName: "back-button").withRenderingMode(.alwaysOriginal)
        let barButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: nil)
        
        return barButtonItem
    }()
    
    lazy var forwardBarButtonItem: UIBarButtonItem = {
        let icon = #imageLiteral(resourceName: "forward-button").withRenderingMode(.alwaysOriginal)
        let barButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: nil)
        
        return barButtonItem
    }()
    
    lazy var searchBarButtonItem: UIBarButtonItem = {
        let icon = #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal)
        let barButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: nil)
        
        return barButtonItem
    }()
    
    lazy var notificationhBarButtonItem: UIBarButtonItem = {
        let icon = #imageLiteral(resourceName: "notification").withRenderingMode(.alwaysOriginal)
        let barButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: nil)
        
        return barButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if navigationController is NavigationViewController {
            navigationController?.navigationBar.isTranslucent = false
        } else {
            print("MainViewController with unnexpected Navigation")
        }
    }

}
