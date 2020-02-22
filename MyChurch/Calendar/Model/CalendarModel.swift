// Bogdan -- 2019
// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

//MARK:-- Calendar model
struct CalendarResponse: Codable {
    let data: [CalendarData]?
}

struct CalendarData: Codable {
    let id, fasting, priority: Int
    let name, date, color: String
}
