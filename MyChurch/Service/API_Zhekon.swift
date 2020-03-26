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
func getDetailTemple(id: Int, completion: ((NewResult<TempleDetailData>) -> Void)?) {
    let api = "http://ec2-3-133-104-185.us-east-2.compute.amazonaws.com"
    let endpoint = ":8081/temple/\(id)"
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
                    let playerResponse = try decoder.decode(TempleDetailData.self, from: jsonData)
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


//http://test.cerkva.asp-win.d2.digital/church/diocese/?n=100


//
//if let httpResponse = response as? HTTPURLResponse {
//    print(httpResponse.statusCode)
//    print(String(decoding: responseData!, as: UTF8.self))
//}
