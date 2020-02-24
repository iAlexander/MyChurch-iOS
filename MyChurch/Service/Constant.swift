// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit


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
}
