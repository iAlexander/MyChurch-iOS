// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

extension UserDefaults {

    enum Keys: String {
        case token
        case userId
        case defaultScreenIndex
        case isDefaultScreenChoosed
        case isPrivacyPolicy
    }
    
    func isLoggedIn() -> Bool {
        let key = UserDefaults.Keys.token.rawValue
        return bool(forKey: key)
    }
    
}
