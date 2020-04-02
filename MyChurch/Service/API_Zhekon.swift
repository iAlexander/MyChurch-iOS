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
    let url = URL(string:"http://ec2-3-133-104-185.us-east-2.compute.amazonaws.com:8081/calendar")
    var request = URLRequest(url: url!)
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
    let api = "http://ec2-3-133-104-185.us-east-2.compute.amazonaws.com"
    let endpoint = ":8081/calendar/id?id=\(id)"
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
    let api = "http://test.cerkva.asp-win.d2.digital/church/card/\(id)"
    let url1 = URL(string: api)
    var request = URLRequest(url: url1!)
    request.httpMethod = "GET"
  //  request.setValue("Bearer 00b26a24-0cc8-3d0a-993d-61641c4439dc", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
    let api = "http://test.cerkva.asp-win.d2.digital/church/list-geo"
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
    let api = "http://test.cerkva.asp-win.d2.digital/church/diocese/?n=100"
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
    let url = URL(string:"http://test.cerkva.asp-win.d2.digital/register")
    var request = URLRequest(url: url!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.httpMethod = "POST"
    let jsonDic = ["firstName": name, "lastName": serName, "email": email, "phone": phone, "member": status, "church": hram, "diocese": eparhiya, "acceptAgreement": true, "angelday":angelday, "birthday": birthday ] as [String : Any]
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
    let url = URL(string:"http://test.cerkva.asp-win.d2.digital/account/login")
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
    let api = "http://test.cerkva.asp-win.d2.digital/account/profile"
    let url1 = URL(string: api)
    var request = URLRequest(url: url1!)
    request.httpMethod = "GET"
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

//MARK: 9) Запрос на логин
func changePasswordApi(oldPass: String, newPassword: String, completion: ((NewResult<ChangePass>) -> Void)?) {
    let url = URL(string:"http://test.cerkva.asp-win.d2.digital/profile/change-password")
    var request = URLRequest(url: url!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.httpMethod = "POST"
    let jsonDic = ["oldPassword": oldPass, "newPassword": newPassword]
    
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
    let url = URL(string:"http://test.cerkva.asp-win.d2.digital/profile/email-change")
    var request = URLRequest(url: url!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.httpMethod = "POST"
    let jsonDic = ["newEmail": newEmail]
    
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
    let url = URL(string:"http://test.cerkva.asp-win.d2.digital/account/forgot-password")
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

//
//if let httpResponse = response as? HTTPURLResponse {
//    print(httpResponse.statusCode)
//    print(String(decoding: responseData!, as: UTF8.self))
//}
