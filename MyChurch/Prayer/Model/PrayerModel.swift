// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

enum PrayerType: String {
    case morning = "Ранкові"
    case evening = "Вечірні"
}

//MARK:-- Prayer model
struct PrayerResponse: Codable {
    let data: [Prayer]?
}

struct Prayer: Codable {
    let id: Int16?
    let title: String?
    let text: String?
    let urlMP3: String?
    let type: String?
}
