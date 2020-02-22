// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

extension NSLayoutConstraint {

    override public var description: String {
        let identifierString = identifier != nil && identifier != "" ? "identifier: \(identifier!), " : ""
        let constantString = "constant: \(constant)"

        let result: String = {
            let selfDependency = "constraint with \(identifierString + constantString)"

            return selfDependency
        }()

        return result
    }
    
}
