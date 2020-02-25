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
