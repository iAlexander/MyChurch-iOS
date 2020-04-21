// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

enum PrayerType: String {
    case morning = "Ранкові"
    case evening = "Вечірні"
}

//MARK:-- Prayer model
struct PrayerResponse: Codable {
    let ok: Bool?
    let data: PrayerList?
}

struct PrayerList: Codable {
    let list: [Prayer]?
}

struct Prayer: Codable {
    let id: Int16?
    let title: String?
    let text: String?
    let file: FileData?
    let type: String?
}

struct FileData: Codable {
    let name: String?
    let path: String?
}
