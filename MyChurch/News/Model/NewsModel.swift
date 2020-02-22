// Bogdan -- 2019
// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

//MARK:-- News model
struct NewsResponse: Codable {
    let ok: Bool
    let data: NewsData
}

struct NewsData: Codable {
    let list: [Article]
}

struct Article: Codable {
    let id: Int
    let name, date, title, notice, text: String?
    let image: ArticleImage?
}

struct ArticleImage: Codable {
    let name: String
    let path: String
}
