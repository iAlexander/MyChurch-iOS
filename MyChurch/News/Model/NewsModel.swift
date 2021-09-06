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

struct NewsWordPressModel: Codable {
    let id: Int
    let date: String?
    let title: Title?
    let featured_media: Int?
    let content: Content?
    
    struct Title: Codable {
        let rendered: String?
    }
    
    struct Content: Codable {
        let rendered: String?
    }
}

struct NewsWordPressImageModel: Codable {
    var media_details: MediaDetails
    
    struct MediaDetails: Codable {
        var sizes: SizesModel
    }
    
    struct SizesModel: Codable {
        var medium: ImageModel
        var full: ImageModel
    }
    
    struct ImageModel: Codable {
        var source_url: String
    }
}
