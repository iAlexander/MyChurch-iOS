// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation
import SwiftSoup

protocol NewsDetailsDelegate: class {
    func didParsingHTML(_ data: [Element])
}

class NewsDetailsViewModel: ViewModel {
    
    init(delegate: NewsDetailsDelegate) {
        self.delegate = delegate
    }
    
    weak var delegate: NewsDetailsDelegate?
    
    func remove(_ html: String) -> String {
        let result = html.replacingOccurrences(of:"(?i)\\{[^\\}]+\\}[^\\}]+\\}",with: "", options: .regularExpression, range: nil)
        
        //        let result =  html.replacingOccurrences(of:"\\{[^\\}]+\\}", with: "", options: .regularExpression, range: nil)
        
        //        let result = html.replacingOccurrences(of: "(?i){gallery\\b[^{]*}\\s*{/gallery}", with: "", options: .regularExpression)
        
        print("!!! remove at \(result)")
        
        return result
    }
    
}
