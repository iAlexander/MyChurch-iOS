// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import Firebase

typealias TabBarData = (title: String, image: UIImage, selectedImage: UIImage)

enum Stage {
    case authorization
    case onboarding
    case main
}

enum Url: String {
    case main = "PCUUrl"
}

enum DateFormat: String {
    case unformatted = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    case unformattedShort = "yyyy-MM-dd'T'HH:mm:ss"
    case unformattedUTC = "yyyy-MM-dd'T'HH:mm:ss+UTC"
    case dayMonth = "d MMMM"
    case dayMonthYear = "dd MMMM yyyy"
    case dayMonthYearShort = "dd.MM.yy"
    case dayMonthYearHoursMinutesShort = "dd.MM.yy HH:mm"
}

enum Localization: String {
    case uk = "uk_UA"
}

struct UserData {
    static private var _userId: String?
    static var userId: String? {
        get {
            if let userId = _userId {
                return userId
            } else if let userId = UserDefaults.standard.string(forKey: UserDefaults.Keys.userId.rawValue) {
                return userId
            } else {
                return nil
            }
        }
        set {
            if let userId = newValue {
                _userId = newValue
                
                UserDefaults.standard.set(userId, forKey: UserDefaults.Keys.userId.rawValue)
            }
        }
    }
    
    static private var _defaultScreenIndex: Int?
    static var defaultScreenIndex: Int {
        get {
            if let defaultScreenIndex = _defaultScreenIndex {
                return defaultScreenIndex
            } else {
                return UserDefaults.standard.integer(forKey: UserDefaults.Keys.defaultScreenIndex.rawValue)
            }
        }
        set {
            _defaultScreenIndex = newValue
            
            UserDefaults.standard.set(newValue, forKey: UserDefaults.Keys.defaultScreenIndex.rawValue)
        }
    }
    
    static private var _isDefaultScreenChoosed: Bool?
    static var isDefaultScreenChoosed: Bool {
        get {
            if let isDefaultScreenChoosed = _isDefaultScreenChoosed {
                return isDefaultScreenChoosed
            } else {
                return UserDefaults.standard.bool(forKey: UserDefaults.Keys.isDefaultScreenChoosed.rawValue)
            }
        }
        set {
            _isDefaultScreenChoosed = newValue
            
            UserDefaults.standard.set(newValue, forKey: UserDefaults.Keys.isDefaultScreenChoosed.rawValue)
        }
    }
}

extension UIViewController {
    func createFirebaseAnalytics(itemID: String, itemName: String, contentType: String) {
        Analytics.logEvent(AnalyticsEventLevelStart, parameters:
            [AnalyticsParameterItemID: itemID,
                                   AnalyticsParameterItemName: itemName, // передавать нейм
                                   AnalyticsParameterItemCategory: contentType, // передавать нейм
                                   AnalyticsParameterContentType: contentType])
        let screenClass = classForCoder.description()
        Analytics.setScreenName(itemName, screenClass: screenClass)

        Analytics.logEvent(AnalyticsEventSelectContent, parameters:
            [AnalyticsParameterItemID: itemID,
                                   AnalyticsParameterItemName: itemName, // передавать нейм
                                   AnalyticsParameterItemCategory: itemName, // передавать нейм
                                   AnalyticsParameterContentType: contentType])

        Analytics.logEvent("select_content", parameters:
            [AnalyticsParameterItemID: itemID,
                                   AnalyticsParameterItemName: itemName, // передавать нейм
                                   AnalyticsParameterItemCategory: contentType, // передавать нейм
                                   AnalyticsParameterQuantity: UserDefaults.standard.integer(forKey: "nbReadPost"),
                                   AnalyticsParameterContentType: contentType])


        //EVENT select POST
        Analytics.logEvent("SELECT_CONTENT", parameters: [
            AnalyticsParameterItemID: itemID,
            AnalyticsParameterItemName: itemName,
            AnalyticsParameterItemCategory: contentType,
            AnalyticsParameterQuantity: UserDefaults.standard.integer(forKey: "nbReadPost")
        ])
    }
}
