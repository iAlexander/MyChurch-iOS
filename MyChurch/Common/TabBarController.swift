// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

enum TabType {
    case map
    case calendar
    case news
    case prayer
    case profile
}

protocol TabBarTypeDelegate: class {
    var tabBarType: Stage { get set }
    
    func resetTab(_ type: TabType)
}

class TabBarController: UITabBarController {
    
    static var shared: TabBarController?
    
    var _tabBarType: Stage {
        get { return self.tabBarType }
        set { self.tabBarType = newValue }
    }
    
    var tabBarType: Stage = .main {
        willSet {
            switch newValue {
                case .authorization:
                    let authLanguageViewController = UIViewController()
                    let navigationController = createNavigationController(authLanguageViewController)
                    self.viewControllers = [navigationController]
                    self.tabBar.isHidden = true
                
                case .onboarding:
                    let onboardingViewController = OnboardingViewController()
                    self.viewControllers = [onboardingViewController]
                    self.tabBar.isHidden = true
                
                case .main:
                    let mapNavigationController: NavigationViewController = {
                        let vacationViewController = MapViewController()
                        let image = createImage(UIImage(named: "map"))
                        let selectedImage = createImage(UIImage(named: "map-tint"))
                        let data: TabBarData = (title: "Карта", image: image, selectedImage: selectedImage)
                        let navigationController = createNavigationController(vacationViewController, data: data)
                        
                        return navigationController
                    }()
                    
                    let calendarNavigationController: NavigationViewController = {
                        let vacationViewController = CalendarViewController()
                        let image = createImage(UIImage(named: "calendar"))
                        let selectedImage = createImage(UIImage(named: "calendar-tint"))
                        let data: TabBarData = (title: "Календар", image: image, selectedImage: selectedImage)
                        let navigationController = createNavigationController(vacationViewController, data: data)
                        
                        return navigationController
                    }()
                    
                    let newsNavigationController: NavigationViewController = {
                        let vacationViewController = NewsViewController()
                        let image = createImage(UIImage(named: "news"))
                        let selectedImage = createImage(UIImage(named: "news-tint"))
                        let data: TabBarData = (title: "Новини", image: image, selectedImage: selectedImage)
                        let navBarConfig = NavigationBarConfig(title: nil, buttons: [.notification])
                        let navigationController = createNavigationController(vacationViewController, data: data, navigationBarConfig: navBarConfig)
                        
                        return navigationController
                    }()
                    
                    let prayerNavigationController: NavigationViewController = {
                        let vacationViewController = PrayerViewController()
                        let image = createImage(UIImage(named: "prayer"))
                        let selectedImage = createImage(UIImage(named: "prayer-tint"))
                        let data: TabBarData = (title: "Молитви", image: image, selectedImage: selectedImage)
                        let navigationController = createNavigationController(vacationViewController, data: data)
                        
                        return navigationController
                    }()
                    
                    let accountNavigationController: NavigationViewController = {
                        let vacationViewController = RegistrationFirstPageViewController() 
                        let image = createImage(UIImage(named: "account"))
                        let selectedImage = createImage(UIImage(named: "account-tint"))
                        let data: TabBarData = (title: "Профіль", image: image, selectedImage: selectedImage)
                        let navigationController = createNavigationController(vacationViewController, data: data)
                        
                        return navigationController
                    }()
                    
                    self.viewControllers = [mapNavigationController, calendarNavigationController, newsNavigationController, prayerNavigationController, accountNavigationController]
                    self.selectedIndex = UserData.defaultScreenIndex
                    self.tabBar.isHidden = false
            }
        }
    }
    
    var backgroundColor: UIColor = .white {
        willSet {
            self.view.backgroundColor = newValue
        }
    }
    
    override func loadView() {
        super.loadView()
        
        // Do any additional setup before loading the view.
        TabBarController.shared = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tabBar.isTranslucent = false
//        let key = UserDefaults.Keys.userId.rawValue
//        let isLoggedIn = UserDefaults.standard.string(forKey: key)
//        self.tabBarType = isLoggedIn != nil ? .main : .authorization

        self.tabBarType = UserData.isDefaultScreenChoosed ? .main : .onboarding
        setupLayout()
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .white
        self.tabBar.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
//        self.tabBar.tintColor = Color.lightGrayColor
        
        // Autolayouts
        // here should be all TabBarController's constraints
    }
    
}

extension TabBarController: TabBarTypeDelegate {
    
    func resetTab(_ type: TabType) {
        switch type {
            case .map:
                let certificate: NavigationViewController = {
                    let certificateViewController = MapViewController()
                    let image = createImage(UIImage(named: "map")!)
                    let selectedImage = createImage(UIImage(named: "map-tint")!)
                    let data: TabBarData = (title: "Карта", image: image, selectedImage: selectedImage)
                    let navigationController = createNavigationController(certificateViewController, data: data)
                    
                    return navigationController
                }()
                
                self.viewControllers?[0] = certificate
            case .calendar, .news, .prayer, .profile: ()
        }
    }
    
    private func createNavigationController(_ vc: UIViewController, data: TabBarData? = nil, navigationBarConfig: NavigationBarConfig? = nil) -> NavigationViewController {
        let viewController = vc
        let navigationController = NavigationViewController(rootViewController: viewController)
        
        if let data = data {
            navigationController.tabBarItem.title = data.title
            navigationController.tabBarItem.image = data.image
            navigationController.tabBarItem.selectedImage = data.selectedImage
        }
        
        return navigationController
    }
    
    func createImage(_ image: UIImage?) -> UIImage {
        guard let image = image?.withRenderingMode(.alwaysOriginal) else { return UIImage() }
        
        return image
    }
    
}
