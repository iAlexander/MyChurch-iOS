// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

enum EndPoint: String {
    // GET method
    // Temples
    case temples = "temple"
    // Calendar
    case calendar = "calendar"
    // News
    case news = "pages/news"
}

enum API: String {
    case stage = "http://ec2-3-133-104-185.us-east-2.compute.amazonaws.com:8081/"
    case acp = "http://test.cerkva.asp-win.d2.digital/"
}

//struct API {
//    static let stageA = "http://ec2-3-133-104-185.us-east-2.compute.amazonaws.com:8081/"
//    static let stageB = "http://test.cerkva.asp-win.d2.digital/"
//    static var current = stageA
//}
