//
//  ServiceSettings.swift
//  SchoolUp
//
//  Created by Nguyen Ha on 02/02/2023.
//

import Foundation

public class ServiceSettings {

    private struct Keys {
        static let accessToken = "KEY_ACCESS_TOKEN"
        static let parentInfo = "KEY_PARENT_INFO"
        static let studentInfo = "KEY_STUDENT_INFO"
        static let demoDomain = "KEY_DEMO_DOMAIN"
        static let students = "KEY_STUDENTS"
        static let classInfo = "KEY_CLASS_INFO"
        static let isComment = "IS_COMMENT"
        static let locale = "KEY_LOCALE"
        static let isRegisterDevice = "IS_REGISTER_DEVICE"
        static let isPushRemote = "KEY_PUSH_REMOTE"
        static let listRegisteredClass = "KEY_REGISTERED_CLASS"
    }

    public static var shared = ServiceSettings()
    private let userDefaults = UserDefaults.standard

    var accessToken: String? {
        get {
            return userDefaults.string(forKey: Keys.accessToken)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.accessToken)
            userDefaults.synchronize()
        }
    }

    var demoDomain: String? {
        get {
            return userDefaults.string(forKey: Keys.demoDomain)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.demoDomain)
            userDefaults.synchronize()
        }
    }

    var userInfo: UserModel? {
        get {
            userDefaults.loadCodableObject(forkey: Keys.parentInfo)
        }
        set {
            userDefaults.storeCodableObject(newValue, forkey: Keys.parentInfo)
        }
    }

    var isComment: Bool {
        get {
            return userDefaults.bool(forKey: Keys.isComment)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.isComment)
            userDefaults.synchronize()
        }
    }

    func clearUserInfo() {
        ServiceSettings.shared.userInfo = nil
//        AppDelegate.shared.setRootVC()
    }

    var isRegisterDevice: Bool {
        get {
            return userDefaults.bool(forKey: Keys.isRegisterDevice)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.isRegisterDevice)
            userDefaults.synchronize()
        }
    }
    
    var isPushRemote: Bool {
        get {
            return userDefaults.bool(forKey: Keys.isPushRemote)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.isPushRemote)
            userDefaults.synchronize()
        }
    }
    
//    var listRegisteredClass: [ScheduleParamObject] {
//        get {
//            return userDefaults.bool(forKey: Keys.listRegisteredClass)
//        }
//        set {
//            userDefaults.set(newValue, forKey: Keys.listRegisteredClass)
//            userDefaults.synchronize()
//        }
//    }
}
