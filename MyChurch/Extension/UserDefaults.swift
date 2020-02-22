// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

extension UserDefaults {

    enum Keys: String {
        case token
        case language
        case userId
        case boardCardId
    }
    
    func isLoggedIn() -> Bool {
        let key = UserDefaults.Keys.token.rawValue
        return bool(forKey: key)
    }
    
}
