//
//  Constants.swift
//  GymCare
//
//

import Foundation
import UIKit

struct Constants {
    static let WIDTH_SCREEN = UIScreen.main.bounds.width
    static let HEIGHT_SCREEN = UIScreen.main.bounds.height
    static let TIME_OUT: Double = 60
    static let MAX_UPLOAD_IMAGE: Float = 2.0
    static let DEALY_TIME = DispatchTimeInterval.seconds(1)
    static let DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss"
    static let DATE_TIME_FORMAT_IMAGE = "yyyyMMddHHmmss"
    static let DATE_MONTH_FORMAT = "dd/MM"
    static let DATE_FORMAT = "dd/MM/yyyy"
    static let DATE_FORMAT_2 = "yyyy/MM/dd"
    static let DATE_PARAM_FORMAT = "yyyy-MM-dd"
    static let DATE_TIME_FORMAT_2 = "dd/MM/yyyy HH:mm:ss"
    static let DATE_TIME_FORMAT_3 = "hh:mm, dd/MM/yyyy"
    static let DATE_TIME_FORMAT_4 = "hh:mm, dd/MM"
    static let YEAR_STRING = "yyyy"
    static let MONTH_STRING = "MM"
    static let MONTH_STYLE_STRING = "MM/yyyy"
    static let MONTH_PARAM_STRING = "MM-yyyy"
    static let MONTH_PARAM_STRING_2 = "yyyy-MM"
    static let QUARTER_STYLE_STRING = "q/yyyy"
    static let QUARTER_STRING = "q"
    static let DAY_STRING = "dd"
    static let HOUR_STRING = "HH:mm"
    static let HOUR_STRING_MIN = "HH:mm:ss"
    static let HOUR_STRING_SYMBOL = "HH:mm a"
    static let HOUR_STRING_SYMBOL_NOMAR = "hh:mm a"
    static let DATE_TIME_FORMAT_24h = "yyyy-MM-dd HH:mm:ss"
    static let DATE_TIME_FORMAT_SYMBOL_24h = "yyyy-MM-dd HH:mm a"
    static let DATE_TIME_FORMAT_SYMBOL = "yyyy-MM-dd hh:mm a"
    static let SUFFIX_JSON = ".php"
    static let minIncome = Double(10000000)
    static let comma = ","
    static let amSymbol = "AM"
    static let pmSymbol = "PM"
    static let dateInWeek = "EEEE"
    static let locateIdentifierEnUS = "en_US_POSIX"
    static var selectedLanguage = "vi"
    static var messages = 2
    static var notification = 1
    static var LONGTITUDE: Double = 35.6679191
    static var LATITUDE: Double = 139.4606805
}

struct EndPointURL {
    static let BASE_API_URL: String = Config.shared.BASE_API_URL
    static let POLICY_URL: String = Config.shared.POLICY_URL
    static let versionJson = Config.shared.versionJson
    static let versionJsonOnly = Config.shared.versionJsonOnly
    static let IMAGE_URL: String = Config.shared.BASE_API_URL + "/" + "gymcare/"
    static let LOGIN: String = versionJson + "login" + Constants.SUFFIX_JSON
    static let REGISTER: String = versionJson + "register" + Constants.SUFFIX_JSON
    static let USER: String = versionJson + "customer" + Constants.SUFFIX_JSON
    static let RESET_PASS: String = versionJson + "password/reset" + Constants.SUFFIX_JSON
    static let UPDATE_PASS: String = versionJson + "password/update" + Constants.SUFFIX_JSON
    static let CHANGE_PASS: String = versionJson + "password/change" + Constants.SUFFIX_JSON
    static let GET_CLASS: String = versionJson + "class" + Constants.SUFFIX_JSON
    static let GET_CLASS_INFO: String = versionJson + "get_class" + Constants.SUFFIX_JSON
    static let GET_ADDRESS: String = versionJson + "address" + Constants.SUFFIX_JSON
    static let GET_CLASS_DETAIL: String = versionJson + "class" + Constants.SUFFIX_JSON
    static let GET_TOPICS: String = versionJson + "chat" + Constants.SUFFIX_JSON
    static let GET_TOPIC_DETAIL: String = versionJson + "message" + Constants.SUFFIX_JSON
    static let RELOAD_CHAT_DETAIL: String = versionJson + "reload_message" + Constants.SUFFIX_JSON
    static let GET_TRAINER: String = versionJson + "trainer" + Constants.SUFFIX_JSON
    static let CREATE_SCHEDULE: String = versionJson + "schedule" + Constants.SUFFIX_JSON
    static let CREATE_NOTIFICATION: String = versionJson + "notification" + Constants.SUFFIX_JSON
    static let UPDATE_STATUS_NOTIFICATION: String = versionJson + "update_noti_status" + Constants.SUFFIX_JSON
    static let PAYMENT: String = versionJson + "payment" + Constants.SUFFIX_JSON
    static let TARGET: String = versionJson + "target" + Constants.SUFFIX_JSON
    static let NEWS: String = versionJson + "news" + Constants.SUFFIX_JSON
    static let CHECK: String = versionJson + "check" + Constants.SUFFIX_JSON
    static let HEALTH: String = versionJson + "health" + Constants.SUFFIX_JSON

}

enum GradiantDirection {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
}

public enum ToastStyle {
    case success
    case danger
    case waring
    case info
    case noti
}

public enum Permission: String {
    case IN_OUT_CLASS = "1"
    case IN_OUT_BUS = "2"
    case ALBUM = "3"
    case MENU = "4"
    case MENU_ONLY_VIEW = "-4"
    case HEALTH = "5"
    case SCHEDULE = "6"
    case SCHEDULE_ONLY_VIEW = "-6"
    case MESSAGE = "7"
    case ABSENCE = "8"
    case ABSENCE_ONLY_VIEW = "-8"
    case REMINDER = "9"
    case REMINDER_ONLY_VIEW = "-9"
    case PEEPOO = "10"
    case PEEPOO_ONLY_VIEW = "-10"
    case BUS_TRACKING = "15"
}

enum PushNotificationType: String {
    case NOTIFICATION = "1"
    case TOPIC = "2"
    case INOUT_BUS = "3"
    case INOUT_CLASS = "4"
    case ALBUM = "5"
    case FEE = "6"
    case ABSENCE = "7"
    case HEALTH = "8"
    case REMINDER = "9"
    case PEE_POO = "10"
    case BUS_OFF = "15"
    case CHAT_ROOM = "20"
    case SURVEY = "22"
}

enum Permission_Menu: String {
    case CHECK_IN = "1"
    case ALBUM = "2"
    case MENU = "3"
    case SCHEDULE = "4"
    case ABSENCE = "5"
    case IN_OUT = "6"
    case MESSAGE = "7"
    case HEALTH = "8"
    case REVIEW = "9"
    case PEEPOO = "10"
    case REMINDER = "11"
    case FEE = "12"
    case CHAT_ROOM_CHECKIN = "13"
    case BUS_TRACKING = "15"
    case SURVEY = "16"
    case COMMENT = "17"
    case EXTRACURRICULAR = "18"
}

enum MENU_PUSH: String {
    case DAILY_EMAIL = "1"
    case WEEKLY_EMAIL = "2"
    case MONTHLY_EMAIL = "3"
    case YEARS_EMAIL = "4"
    case DAILY_APP = "5"
    case WEEKLY_APP = "6"
    case MONTHLY_APP = "7"
    case YEARS_APP = "8"
}

enum KeyPushRemote: String {
    case type = "type"
    case id = "id"

}

enum ImageViewType {
    case one
    case two
    case three
    case other
}

enum TypeMeal: Int, CaseIterable {
    case breakfast
    case extra_lunch
    case lunch
    case extra_dinner

    var image: UIImage? {
        switch self {
        case .breakfast:
            return #imageLiteral(resourceName: "ic_sunrise")
        case .extra_lunch:
            return #imageLiteral(resourceName: "ic_sunrise2")
        case .lunch:
            return #imageLiteral(resourceName: "ic_sun")
        case .extra_dinner:
            return #imageLiteral(resourceName: "ic_sunset2")
        }
    }
}

enum TypeDay: Int, CaseIterable {
    case morning
    case afternoon
    
    var image: UIImage? {
        switch self {
        case .morning:
            return #imageLiteral(resourceName: "ic_sunrise")
        case .afternoon:
            return #imageLiteral(resourceName: "ic_sunrise2")
        }
    }
}

enum TypeDate: Int {
    case null
    case day
    case time
}

enum TypeStatus: Int {
    case ignore
    case acceptUpdate
    case viewOnly
    case acceptCreate
    case create
    case update
}
