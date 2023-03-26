//
//  Notification+Extension.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 08/01/2023.
//

import Foundation

extension Notification.Name {
    static let RELOAD_ALBUM_SCREEN = Notification.Name("RELOAD_ALBUM_SCREEN")
    static let RELOAD_ALBUM_DETAIL_SCREEN = Notification.Name("RELOAD_ALBUM_DETAIL_SCREEN")
    static let GO_TAP_ALBUM = Notification.Name("GO_TAP_ALBUM")
    static let GO_TAP_IN_OUT = Notification.Name("GO_TAP_IN_OUT")
    static let GO_TAP_MESSAGE = Notification.Name("GO_TAP_MESSAGE")
    static let RELOAD_TAP_MESSAGE_BY_TYPE = Notification.Name("RELOAD_TAP_MESSAGE_BY_TYPE")
    static let LOGOUT = Notification.Name(rawValue: "LOGOUT")
}
