//
//  API_Zhekon.swift
//  MyChurch
//
//  Created by Zhekon on 25.02.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import Foundation

enum NewResult<Value> {
    case success(Value)
    case partialSuccess(String)
    case failure(Error)
}


//MARK: 1) Запрос на взятие праздников для календаря
func getHolidays(completion: ((NewResult<HolidaysAllData>) -> Void)?) {
    let url = URL(string:"https://mobile.pomisna.info/gala/?n=all")
    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let playerResponse = try decoder.decode(HolidaysAllData.self, from: jsonData)
                    completion?(.success(playerResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 2) Запрос на взятие детального праздника
func getDetailHolidays(id: Int, completion: ((NewResult<HolidaysDetailData>) -> Void)?) {
    let api = "https://mobile.pomisna.info"
    let endpoint = "/calendar/id?id=\(id)"
    let url1 = URL(string: api + endpoint)
    
    var request = URLRequest(url: url1!)

    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let playerResponse = try decoder.decode(HolidaysDetailData.self, from: jsonData)
                    completion?(.success(playerResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 3) Запрос на взятие детального храма
func getDetailTemple(id: Int, completion: ((NewResult<TempleData>) -> Void)?) {
    let api = "https://mobile.pomisna.info/church/card/\(id)"
    let url1 = URL(string: api)
    var request = URLRequest(url: url1!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let playerResponse = try decoder.decode(TempleData.self, from: jsonData)
                    completion?(.success(playerResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 4) Запрос на взятие всех храмов
func getAllHrams( completion: ((NewResult<AllHrams>) -> Void)?) {
    let api = "https://mobile.pomisna.info/church/list-geo"
    let url1 = URL(string: api)
    var request = URLRequest(url: url1!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let playerResponse = try decoder.decode(AllHrams.self, from: jsonData)
                    completion?(.success(playerResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 5) Запрос на взятие всех епархий
func getAllEparhies(completion: ((NewResult<EparhiesData>) -> Void)?) {
    let api = "https://mobile.pomisna.info/church/diocese/?n=100"
    let url1 = URL(string: api)
    var request = URLRequest(url: url1!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let playerResponse = try decoder.decode(EparhiesData.self, from: jsonData)
                    completion?(.success(playerResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 6) Запрос на регистрацию
func registrationUser(name: String, serName: String, birthday: String, phone: String, email: String, status: String, hram: Int, eparhiya: Int, angelday: String, completion: ((NewResult<RegistrationData>) -> Void)?) {
//   let url = URL(string:"http://test.cerkva.asp-win.d2.digital/register")
    let url = URL(string:"https://mobile.pomisna.info/register")
    var request = URLRequest(url: url!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.httpMethod = "POST"
    var jsonDic = [String:Any]()
    
    if hram == 0 {
        jsonDic = ["firstName": name, "lastName": serName, "email": email, "phone": phone, "member": status, "diocese": eparhiya, "acceptAgreement": true, "angelday":angelday, "birthday": birthday, "firebaseToken": UserDefaults.standard.value(forKey:"firToken") ?? "" ] as [String : Any]
    }
    
    if eparhiya == 0 {
        jsonDic = ["firstName": name, "lastName": serName, "email": email, "phone": phone, "member": status, "church": hram, "acceptAgreement": true, "angelday":angelday, "birthday": birthday, "firebaseToken": UserDefaults.standard.value(forKey:"firToken") ?? "" ] as [String : Any]
    }
    
    if eparhiya == 0 && hram == 0 {
        jsonDic = ["firstName": name, "lastName": serName, "email": email, "phone": phone, "member": status, "acceptAgreement": true, "angelday":angelday, "birthday": birthday, "firebaseToken": UserDefaults.standard.value(forKey:"firToken") ?? "" ] as [String : Any]
    }
    
    if eparhiya != 0 && hram != 0 {
        jsonDic = ["firstName": name, "lastName": serName, "email": email, "phone": phone, "member": status, "church": hram, "diocese": eparhiya, "acceptAgreement": true, "angelday":angelday, "birthday": birthday, "firebaseToken": UserDefaults.standard.value(forKey:"firToken") ?? "" ] as [String : Any]
    }
    
    if let theJSONData = try? JSONSerialization.data(withJSONObject: jsonDic, options: []) {
        request.httpBody = theJSONData
    }
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let httpResponse = response as? HTTPURLResponse {
                          print(httpResponse.statusCode)
                          print(String(decoding: responseData!, as: UTF8.self))
                
                      }
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let DeviceResponse = try decoder.decode(RegistrationData.self, from: jsonData)
                    completion?(.success(DeviceResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 7) Запрос на логин
func signUpUser(email: String, password: String, completion: ((NewResult<RegistrationData>) -> Void)?) {
//   let url = URL(string:"http://test.cerkva.asp-win.d2.digital/account/login")
    let url = URL(string:"https://mobile.pomisna.info/account/login")
    var request = URLRequest(url: url!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.httpMethod = "POST"
    let jsonDic = ["login": email, "password": password]
    if let theJSONData = try? JSONSerialization.data(withJSONObject: jsonDic, options: []) {
        request.httpBody = theJSONData
    }
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                print(String(decoding: responseData!, as: UTF8.self))
            }
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let DeviceResponse = try decoder.decode(RegistrationData.self, from: jsonData)
                    completion?(.success(DeviceResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 8) Запрос на взятие данных профиля
func getUserData(completion: ((NewResult<UserDatas>) -> Void)?) {
//    let api = "http://test.cerkva.asp-win.d2.digital/account/profile"
    let api = "https://mobile.pomisna.info/account/profile"
    let url1 = URL(string: api)
    var request = URLRequest(url: url1!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.setValue("Bearer \(UserDefaults.standard.string(forKey: "BarearToken") ?? "")", forHTTPHeaderField: "Authorization")
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
//                print(String(decoding: jsonData, as: UTF8.self))
                let decoder = JSONDecoder()
                do {
                    let playerResponse = try decoder.decode(UserDatas.self, from: jsonData)
                    completion?(.success(playerResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 9) Запрос на смену пароля
func changePasswordApi(oldPass: String, newPassword: String, completion: ((NewResult<ChangePass>) -> Void)?) {
    let url = URL(string:"https://mobile.pomisna.info/profile/change-password")
    var request = URLRequest(url: url!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.setValue("Bearer \(UserDefaults.standard.string(forKey: "BarearToken") ?? "")", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
    let jsonDic = ["oldPassword": oldPass, "newPassword": newPassword]
    
    if let theJSONData = try? JSONSerialization.data(withJSONObject: jsonDic, options: []) {
        request.httpBody = theJSONData
    }
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                print(String(decoding: responseData!, as: UTF8.self))
            }
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let DeviceResponse = try decoder.decode(ChangePass.self, from: jsonData)
                    completion?(.success(DeviceResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 10) Запрос на смену email
func changeEmailApi(newEmail: String, completion: ((NewResult<ChangeEmail>) -> Void)?) {
    let url = URL(string:"https://mobile.pomisna.info/profile/email-change")
    var request = URLRequest(url: url!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.setValue("Bearer \(UserDefaults.standard.string(forKey: "BarearToken") ?? "")", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
    let jsonDic = ["newEmail": newEmail]
    if let theJSONData = try? JSONSerialization.data(withJSONObject: jsonDic, options: []) {
        request.httpBody = theJSONData
    }
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                print(String(decoding: responseData!, as: UTF8.self))
            }
            
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let DeviceResponse = try decoder.decode(ChangeEmail.self, from: jsonData)
                    completion?(.success(DeviceResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 11) Запрос на восстановление пароля
func rememberPassApi(email: String, completion: ((NewResult<RememberPass>) -> Void)?) {
    let url = URL(string:"https://mobile.pomisna.info/account/forgot-password")
    var request = URLRequest(url: url!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.httpMethod = "POST"
    let jsonDic = ["login": email]
    
    if let theJSONData = try? JSONSerialization.data(withJSONObject: jsonDic, options: []) {
        request.httpBody = theJSONData
    }
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                print(String(decoding: responseData!, as: UTF8.self))
            }
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let DeviceResponse = try decoder.decode(RememberPass.self, from: jsonData)
                    completion?(.success(DeviceResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 13) Запрос на восстановление email (часть 2 ) подтверждение кода
func confimEmail(userUid: String, code: String, newEmail:String, completion: ((NewResult<RememberPass>) -> Void)?) {
    let url = URL(string:"https://mobile.pomisna.info/profile/confirm-change-email")
    var request = URLRequest(url: url!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.setValue("Bearer \(UserDefaults.standard.string(forKey: "BarearToken") ?? "")", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
    let jsonDic = ["userUid": userUid, "code":code, "newEmail": newEmail]
    
    if let theJSONData = try? JSONSerialization.data(withJSONObject: jsonDic, options: []) {
        request.httpBody = theJSONData
    }
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                print(String(decoding: responseData!, as: UTF8.self))
            }
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let DeviceResponse = try decoder.decode(RememberPass.self, from: jsonData)
                    completion?(.success(DeviceResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 14) Запрос на взятие данных уведомлений с профиля
func getUserAllNotification(completion: ((NewResult<UserNotifocation>) -> Void)?) {
    let api = "https://mobile.pomisna.info/notification/history"
    let url1 = URL(string: api)
    var request = URLRequest(url: url1!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.setValue("Bearer \(UserDefaults.standard.string(forKey: "BarearToken") ?? "")", forHTTPHeaderField: "Authorization")
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(UserNotifocation.self, from: jsonData)
                    completion?(.success(response))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 15) Запрос на взятие детальных данных уведомлений с профиля
func getUserDetailNotification(notificationId : String, completion: ((NewResult<UserNotifocationDetail>) -> Void)?) {
    let api = "https://mobile.pomisna.info/notification/card/\(notificationId)"
    let url1 = URL(string: api)
    var request = URLRequest(url: url1!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.setValue("Bearer \(UserDefaults.standard.string(forKey: "BarearToken") ?? "")", forHTTPHeaderField: "Authorization")
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                print(String(decoding: responseData!, as: UTF8.self))
                
            }
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(UserNotifocationDetail.self, from: jsonData)
                    completion?(.success(response))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 16) Запрос на отправку пуш токена на логине
func sendFirToken(completion: ((NewResult<FirTokenData>) -> Void)?) {
    let url = URL(string:"https://mobile.pomisna.info/account/token-update")
    var request = URLRequest(url: url!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.httpMethod = "POST"
    let jsonDic = ["firebaseToken": UserDefaults.standard.value(forKey:"firToken") ?? "" ] as [String : Any]
    if let theJSONData = try? JSONSerialization.data(withJSONObject: jsonDic, options: []) {
        request.httpBody = theJSONData
    }
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let DeviceResponse = try decoder.decode(FirTokenData.self, from: jsonData)
                    completion?(.success(DeviceResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 17) Запрос-отправка ликПей на бек
func sendLikPayData(value: String, completion: ((NewResult<SendLiqPayData>) -> Void)?) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "mobile.pomisna.info"
//    urlComponents.scheme = "http"
//    urlComponents.host = "test.cerkva.asp-win.d2.digital"
    urlComponents.path = "/api/pay/generate-liqpay-url"
    urlComponents.queryItems = [URLQueryItem(name: "actionType", value: value), URLQueryItem(name: "resultUrl", value: "https://wwww.google.com")]
    
    guard let url = urlComponents.url else {
        print("__error: Could not create URL from components")
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(UserDefaults.standard.string(forKey: "BarearToken") ?? "")", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")

    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let clubAdsResponse = try decoder.decode(SendLiqPayData.self, from: jsonData)
                    completion?(.success(clubAdsResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 18) Запрос-отправка ликПей подписка на бек
func sendLikPayDataSubscribe(value: String, amount: String, completion: ((NewResult<SendLiqPayData>) -> Void)?) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "mobile.pomisna.info"
//    urlComponents.scheme = "http" //"https"
//    urlComponents.host = "test.cerkva.asp-win.d2.digital"// "mobile.pomisna.info"
    urlComponents.path = "/api/pay/generate-liqpay-url"
    urlComponents.queryItems = [URLQueryItem(name: "actionType", value: "subscribe"), URLQueryItem(name: "resultUrl", value: "https://wwww.google.com"), URLQueryItem(name: "amount", value: amount)]
    
    guard let url = urlComponents.url else {
        print("__error: Could not create URL from components")
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(UserDefaults.standard.string(forKey: "BarearToken") ?? "")", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")

    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                print(String(decoding: responseData!, as: UTF8.self))
            }
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let clubAdsResponse = try decoder.decode(SendLiqPayData.self, from: jsonData)
                    completion?(.success(clubAdsResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 19) Запрос-отправка на отписку
func deSubscribe(completion: ((NewResult<SendLiqPayData>) -> Void)?) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "mobile.pomisna.info"
//    urlComponents.scheme = "http" //"https"
//    urlComponents.host = "test.cerkva.asp-win.d2.digital"// "mobile.pomisna.info"
    urlComponents.path = "/api/pay/unsubscribe-liqpay"
   // urlComponents.queryItems = [URLQueryItem(name: "actionType", value: "subscribe"), URLQueryItem(name: "resultUrl", value: "https://wwww.google.com"), URLQueryItem(name: "amount", value: amount)]
    guard let url = urlComponents.url else {
        print("__error: Could not create URL from components")
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(UserDefaults.standard.string(forKey: "BarearToken") ?? "")", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")

    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                print(String(decoding: responseData!, as: UTF8.self))
                
            }
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let clubAdsResponse = try decoder.decode(SendLiqPayData.self, from: jsonData)
                    completion?(.success(clubAdsResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}

//MARK: 20) Запрос  ликПей  история
func getHistoryLiqPay(completion: ((NewResult<HistoryLiqPayData>) -> Void)?) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "mobile.pomisna.info"
//    urlComponents.scheme = "http" //"https"
//    urlComponents.host = "test.cerkva.asp-win.d2.digital"// "mobile.pomisna.info"
    urlComponents.path = "/api/pay/history-liqpay"
    urlComponents.queryItems = [URLQueryItem(name: "n", value: "20")]
    
    guard let url = urlComponents.url else {
        print("__error: Could not create URL from components")
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(UserDefaults.standard.string(forKey: "BarearToken") ?? "")", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")

    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                print(String(decoding: responseData!, as: UTF8.self))
                
            }
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let clubAdsResponse = try decoder.decode(HistoryLiqPayData.self, from: jsonData)
                    completion?(.success(clubAdsResponse))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}



//if let httpResponse = response as? HTTPURLResponse {
//    print(httpResponse.statusCode)
//    print(String(decoding: responseData!, as: UTF8.self))
//}
