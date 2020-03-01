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
