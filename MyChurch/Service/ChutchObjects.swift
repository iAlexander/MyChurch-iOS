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
struct TempleData: Codable {
    let data: TempleDetailData?
}
struct TempleDetailData: Codable {
    let id: Int?
    let name: String?
    let galaDay: String?
    let galaDayTitle: String?
    //   let phone: String?
    let bishop: IdName?
    let priest: IdName?
    let presiding: IdName?
    let diocese: IdName?
    let dioceseType: IdName?
    // let workSchedule: WorkSchedule?
    //  let churchgeo: Churchgeo?
    let street: String?
    let district: String?
    let locality: String?
    let schedule: String?
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
    let name: String?
}

struct WorkSchedule: Codable {
    let id: Int?
    let schedule: String?
}

// MARK: работаю с объектом для взятия всех храмов
struct AllHrams: Codable {
    let list: [HramInfo]?
}

struct HramInfo: Codable {
    let id: Int?
    let name: String?
    let lt: Float?
    let lg: Float?
}

// MARK: работаю с объектом для взятия всех епархий
struct EparhiesData: Codable {
    let list: [EparhiesList]?
}

struct EparhiesList: Codable {
    let id: Int?
    let name: String?
}

// MARK: работаю с объектом при регистрации пользователя
struct RegistrationData: Codable {
    let data: AccessToken?
}

struct AccessToken: Codable {
    let accessToken: String?
}

// MARK: работаю с объектом при взятии данных юзера
struct UserDatas: Codable {
    var data: UserInfo?
}

struct UserInfo: Codable {
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?
}

// MARK: работаю с объектом при изменении пароля
struct ChangePass: Codable {
    let data: PassInfo?
}

struct PassInfo: Codable {
    let oldPassword: String?
    let newPassword: String?
}

// MARK: работаю с объектом при изменении email
struct ChangeEmail: Codable {
    let data: EmailInfo?
}

struct EmailInfo: Codable {
    let userUid: String?
}

// MARK: работаю с объектом при восстановлении пароля
struct RememberPass: Codable {
    let version: String?
    let ok: Bool?
}
