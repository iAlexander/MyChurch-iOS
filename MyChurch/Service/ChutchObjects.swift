//
//  ChutchObjects.swift
//  MyChurch
//
//  Created by Zhekon on 25.02.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import Foundation
import UIKit

// MARK: работаю с объектом для взятия праздников
struct HolidaysAllData: Codable {
    let data: [HolidaysData]?
}

struct HolidaysData: Codable {
    let id: Int?
    let name: String?
    var date: String?
}

// MARK: работаю с объектом для взятия праздников
struct HolidaysDetailData: Codable {
    let data: HolidayData?
}

struct HolidayData: Codable {
    let id: Int?
    let dateOldStyle: String?
    let dateNewStyle: String?
    let name: String?
    let describe: String?
    let conceived: String?
    let groupId: HolidayDataDetail?
}

struct HolidayDataDetail: Codable {
    let name: String?
}

// MARK: работаю с объектом для взятия конкретного храма
struct TempleDetailData: Codable {
    let data: TempleData?
}

struct TempleData: Codable {
    let id: Int?
    let name: String?
    let galaDay: String?
    let galaDayTitle: String?
    let phone: String?
    let bishop: IdName?
    let presiding: IdName?
    let diocese: IdName?
    let dioceseType: DioceseType?
    let workSchedule: WorkSchedule?
    let churchgeo: Churchgeo?
}

struct Churchgeo: Codable {
    let id: Int?
    let street: String?
    let locality: String?
    let region:String?
}

struct IdName: Codable {
    let id: Int?
    let name: String?
}

struct DioceseType: Codable {
    let id: Int?
    let type: String?
}

struct WorkSchedule: Codable {
    let id: Int?
    let schedule: String?
}




