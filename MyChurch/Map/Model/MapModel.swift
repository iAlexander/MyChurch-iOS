// Bogdan -- 2019
// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

//MARK:-- Temples model
struct TemplesData: Codable {
    let list: [Temple]
}

struct Temple: Codable, Equatable {
    let id: Int
    let name: String
    let lt: Double
    let lg: Double
    var distance: Double?
    let locality: String?
}
