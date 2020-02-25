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
