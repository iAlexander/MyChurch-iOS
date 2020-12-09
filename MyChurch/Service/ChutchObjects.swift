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
    let data: HolidaysListData?
}

struct HolidaysListData: Codable {
    let list: [HolidaysData]?
}

struct HolidaysData: Codable {
    let id: Int?
    let group: GroupData?
    let iconImage: ImageInfo?
    let dateOldStyle: String?
    var dateNewStyle: String?
    let name: String?
    let describe: String?
    let conceived: String?
    let priority: Int?
}
struct ImageInfo: Codable {
    let name: String?
    let path: String?
}

struct GroupData: Codable {
    let id: Int?
    let name: String?
    
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
    let phone: String?
    let history: String?
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
    let files: [Files]?
}

struct Files: Codable {
    let file: File
}
struct File: Codable {
    let id: Int?
    let file: FileImage?
}

struct FileImage: Codable {
    let name: String?
    let path: String?
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
    let version: String?
    let ok: Bool?
    let data: AccessToken?
    let accessToken: String?
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
    var church: Church?
    var subscriptionStatus: String?
}

struct Church: Codable {
    var name: String?
    var locality: String?
}

// MARK: работаю с объектом при изменении пароля
struct ChangePass: Codable {
    let ok: Bool?
    let errors: [ErrorInfo]?
    let data: PassInfo?
}

struct PassInfo: Codable {
    let oldPassword: String?
    let newPassword: String?
    let accessToken: String?
}

struct ErrorInfo: Codable {
    let code: String?
    let message: String?
}

// MARK: работаю с объектом при изменении email
struct ChangeEmail: Codable {
    let ok: Bool?
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

// MARK: работаю с объектом при взятии данных нотификаций
struct UserNotifocation: Codable {
    var data: UserNotificationList?
}

struct UserNotificationList: Codable {
    var list: [UserNotificationArray]?
    var accessToken: String?
}

struct UserNotificationArray: Codable {
    var id: Int?
    var title: String?
    var read: Bool?
    var createdAt: String?
}

// MARK: работаю с объектом при взятии детальных данных нотификаций
struct UserNotifocationDetail: Codable {
    var ok: Bool?
    var data: UserDetailDataNotification?
    var accessToken: String?
}

struct UserDetailDataNotification: Codable {
    var id: Int?
    var  title: String?
    var text: String?
    var createdAt: String?
}

// MARK: работаю с объектом при отправке токена
struct FirTokenData: Codable {
    let ok: Bool?
}

// MARK: работаю с объектом при отправке данных на ликПей
struct SendLiqPayData: Codable {
    let ok: Bool?
    let version: String?
    var data: PayData?
    let errors: [ErrorInfo]?
}

struct PayData: Codable {
    let url: String?
    let orderId: String?
}

struct HistoryLiqPayData: Codable {
    let version: String?
    let ok: Bool?
    let data: HistoryArrayLiqPayData?
}

struct HistoryArrayLiqPayData: Codable {
    let list: [ListPay]?
}

struct ListPay : Codable {
    let id : Int?
    let status : String?
    let amount : Decimal?
    let time : String?
    let orderId :String?
}
