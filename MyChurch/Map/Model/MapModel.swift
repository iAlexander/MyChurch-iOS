// Bogdan -- 2019
// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

//MARK:-- Temples model
struct TemplesData: Codable {
    let data: [Temple]
}

struct Temple: Codable, Equatable {
    let id: Int
    let name: String
    let distance: Double
    let lt: String
    let lg: String
    let type: String
}
