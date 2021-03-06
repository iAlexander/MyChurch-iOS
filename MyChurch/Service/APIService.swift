// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation
import Alamofire

typealias JsonDictionary = [String : Any]

enum Headers: String {
    case authorization
    case language = "accept-language"
    case contentType = "Content-Type"
    case accept = "Accept"
}

enum Responses {
    case success(response: String)
    case failure(error: String)
    case notConnectedToInternet
}

protocol APIServiceDelegate {
    func makeUrl(api: API, endPoint: EndPoint) -> String
    func makeUrl(_ dict: [String : String], api: API, endPoint: EndPoint) -> String
    
}

class APIService {
    
    static let shared = APIService()
    
    private let decoder = JSONDecoder()
    private var dataRequestArray: [DataRequest] = []
    private var sessionManager: [String : Alamofire.SessionManager] = [:]
    private lazy var headers: HTTPHeaders = {
        var dict: HTTPHeaders = [:]
        
        let authorizationKey = Headers.authorization.rawValue
        let authorization = UserDefaults.Keys.token.rawValue
        if let authorizationValue = UserDefaults.standard.string(forKey: authorization) {
            dict[authorizationKey] = authorizationValue
        } else {
            //            TabBarController.shared?.tabBarType = .authorization
        }
        
        let contentTypeKey = Headers.contentType.rawValue
        dict[contentTypeKey] = "application/json"
        
        let acceptKey = Headers.accept.rawValue
        dict[acceptKey] = "application/json"
        
        return dict
    }()
    
    // MARK: - Map
    func getTemples(lt: String, lg: String, completion: @escaping (TemplesData?) -> Void) {
//        let url = "http://test.cerkva.asp-win.d2.digital/church/list-geo"
        let url = "https://mobile.pomisna.info/church/list-geo"

        callEndPoint(url) { (response) in
            switch response {
                case .success(let result):
                    let json: String = result
                    do {
                        let data = try self.decoder.decode(TemplesData.self, from: Data(json.utf8))
                        
                        completion(data)
                    } catch {
                        print(error.localizedDescription)
                        completion(nil)
                }
                case .failure(let error):
                    print(">> response Error from failure")
                    print(error)
                    completion(nil)
                default:
                    print(">> response Error from default state")
                    completion(nil)
                    break
            }
        }
    }
    
    // MARK: - News
    func getNews(completion: @escaping (NewsResponse?) -> Void) {
        let dict = [
            "culture" : "uk",
            "n" : "100",
            "sort" : "Date-desc"
        ]
        let url = makeUrl(dict, api: .stage, endPoint: .news)
        let headers = ["Accept" : "application/json"]
        
        callEndPoint(url, headers: headers) { (response) in
            switch response {
                case .success(let result):
                    let json: String = result
                    do {
                        let data = try self.decoder.decode(NewsResponse.self, from: Data(json.utf8))
                        completion(data)
                    } catch {
                        print(error.localizedDescription)
                        completion(nil)
                }
                case .failure(let error):
                    print(error)
                    completion(nil)
                default:
                    break
            }
        }
    }
    
    func getWordPressNews(completion: @escaping ([NewsWordPressModel]?) -> Void) {
        let headers = ["Accept" : "application/json"]
        
        callEndPoint("https://www.pomisna.info/wp-json/wp/v2/posts/?per_page=100", headers: headers) { (response) in
            switch response {
                case .success(let result):
                    let json: String = result
                    do {
                        let data = try self.decoder.decode([NewsWordPressModel].self, from: Data(json.utf8))
                        completion(data)
                    } catch {
                        print(error.localizedDescription)
                        completion(nil)
                }
                case .failure(let error):
                    print(error)
                    completion(nil)
                default:
                    break
            }
        }
    }
    
    // MARK: - Prayer
    func getPrayer(title: String?, type: String?, skip: Int, length: Int, completion: @escaping (PrayerResponse) -> Void) {
        //        let strongTitle = title ?? ""
        //        let strongType = type ?? ""
        let strongSkip = String(skip)
        let strongLength = String(length)
        
        let dict: [String : String] = ["skip" : strongSkip, "length" : strongLength]
        let url = makeUrl(dict, api: .stage, endPoint: .prayer)
        
        callEndPoint(url, headers: headers) { (response) in
            switch response {
                case .success(let result):
                    let json: String = result
                    do {
                        let data = try self.decoder.decode(PrayerResponse.self, from: Data(json.utf8))
                        
                        completion(data)
                    } catch {
                        print(error.localizedDescription)
                }
                case .failure(let error):
                    print(">> response Error from failure")
                    print(error)
                default:
                    print(">> response Error from default state")
                    break
            }
        }
    }
    
    func getPrayer(completion: @escaping (PrayerResponse) -> Void) {
        let dict: [String : String] = ["n" : "all"]
        let url = makeUrl(dict, api: .stage, endPoint: .prayer)
        
        callEndPoint(url, headers: headers) { (response) in
            switch response {
                case .success(let result):
                    let json: String = result
                    do {
                        let data = try self.decoder.decode(PrayerResponse.self, from: Data(json.utf8))
                        
                        completion(data)
                    } catch {
                        print(error.localizedDescription)
                }
                case .failure(let error):
                    print(">> response Error from failure")
                    print(error)
                default:
                    print(">> response Error from default state")
                    break
            }
        }
    }
    
}

extension APIService: APIServiceDelegate {
    
    
    // MARK: - Format
    func makeUrl(api: API, endPoint: EndPoint) -> String {
        let result: String = api.rawValue + endPoint.rawValue
        
        return result
    }
    
    func makeUrl(_ dict: [String : String], api: API, endPoint: EndPoint) -> String {
        var result = api.rawValue + endPoint.rawValue
        
        let removeColon = dict.description.replacingOccurrences(of: ":", with: "=", options: NSString.CompareOptions.literal, range: nil)
        let removedBackslash = removeColon.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
        let removedSquareBrackets = removedBackslash.replacingOccurrences(of: "[", with: "", options: NSString.CompareOptions.literal, range: nil)
        let removedSpaces = removedSquareBrackets.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        let removedComma = removedSpaces.replacingOccurrences(of: ",", with: "&", options: NSString.CompareOptions.literal, range: nil)
        let finalString = removedComma.replacingOccurrences(of: "]", with: "", options: NSString.CompareOptions.literal, range: nil)
        let endPointExtension: String = "?" + finalString
        result += endPointExtension
        
        return result
    }
    
    // MARK: - Request API logic
    private func callEndPoint(_ url: String, method: Alamofire.HTTPMethod = .get, params: JsonDictionary = [:], headers: HTTPHeaders = [:], completion: @escaping (Responses) -> Void) {
        switch method {
            case .post:
                print(">> Request on API .post: \(url)")
                print(">> with params: \(params)")
                print(">> and header: \(headers)")
                request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseString { (response) in
                    
                    print(">> Response: \(response)")
                    self.serializeResponse(response: response, completion: completion)
                    self.sessionManager.removeValue(forKey: url)
                    
            }
            
            case .delete:
                print(">> Request on API .delete: \(url)")
                print(">> with params: \(params)")
                print(">> and header: \(headers)")
                request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseString { (response) in
                    print(">> Response: \(response)")
                    self.serializeResponse(response: response, completion: completion)
                    self.sessionManager.removeValue(forKey: url)
                    
            }
            
            case .get:
                print(">> Request on API .get: \(url)")
                print(">> with params: \(params)")
                print(">> and header: \(headers)")
                request(url, method: method, parameters: params, headers: headers).responseString { (response) in
//                    print(">> Response: \(response)")
                    self.serializeResponse(response: response, completion: completion)
                    self.sessionManager.removeValue(forKey: url)
                    
            }
            
            default: ()
        }
    }
    
    func updateHeaders() {
        self.headers = {
            var dict: HTTPHeaders = [:]
            
            let authorizationKey = Headers.authorization.rawValue
            let authorization = UserDefaults.Keys.token.rawValue
            if let authorizationValue = UserDefaults.standard.string(forKey: authorization) {
                dict[authorizationKey] = authorizationValue
            } else {
                if TabBarController.shared?.tabBarType == .main {
                    TabBarController.shared?.tabBarType = .authorization
                }
            }
            
            //            let localizationKey = Headers.language.rawValue
            //            let localization = UserDefaults.Keys.language.rawValue
            //            if let localizationValue = UserDefaults.standard.string(forKey: localization) {
            //                dict[localizationKey] = localizationValue
            //            } else {
            //                if TabBarController.shared?.tabBarType == .main {
            //                    TabBarController.shared?.tabBarType = .authorization
            //                }
            //            }
            
            return dict
        }()
    }
    
    private func serializeResponse(response: Alamofire.DataResponse<String>,  completion: @escaping (Responses) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            [weak self] in
            guard let strongSelf = self else { return }
            
            guard let urlResponse = response.response else {
                if let error = response.result.error as NSError?, error.code == NSURLErrorNotConnectedToInternet {
                    strongSelf.notConnectedToInternet(completion: completion)
                } else {
                    strongSelf.failure(error: response.result.error as? String,completion: completion)
                }
                return
            }
            
            strongSelf.success(result: response.result.value, headers: urlResponse.allHeaderFields, completion: completion)
        }
    }
    
    private func cancelAllRequests() {
        for dataRequest in self.dataRequestArray {
            dataRequest.cancel()
        }
        
        self.dataRequestArray.removeAll()
    }
    
    private func notConnectedToInternet(completion:@escaping (Responses) -> Void) {
        completion(.notConnectedToInternet)
    }
    
    private func failure(error: String?, completion:@escaping (Responses) -> Void) {
        completion(.failure(error: error ?? "Unexpectedly error"))
    }
    
    private func success(result: String!, headers: [AnyHashable: Any], completion:@escaping (Responses) -> Void) {
        completion(.success(response: result))
    }
    
}
