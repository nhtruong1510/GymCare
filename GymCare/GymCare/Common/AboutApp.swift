//
//  AbountApp.swift
//  CroixApp
//

import Foundation
import UIKit

public struct AboutApp {
    public static var appName: String {
        return castToString(Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName"))
    }

    public static var appVersion: String {
        return castToString(Bundle.main.infoDictionary!["CFBundleShortVersionString"])
    }
    public static var appBuild: String {
        return castToString(Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String))
    }

    public static var bundleIdentifier: String {
        return castToString(Bundle.main.infoDictionary!["CFBundleIdentifier"])
    }

    public static var bundleName: String {
        return castToString(Bundle.main.infoDictionary!["CFBundleName"])
    }

    public static var appStoreURL: URL {
        return URL(string: "your URL")!
    }

    public static var cancelSubURL: URL {
        return URL(string: "https://apps.apple.com/account/subscriptions")!
    }

    static func deviceUuid() -> String {
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        return uuid
    }

    public static var appVersionAndBuild: String {
        let version = appVersion, build = appBuild
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }

    public static let platForm = 0 // 1: Android, 0: iOS

    public static var IDFV: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }

    public static var deviceVersion: String {
        return UIDevice.current.systemVersion
    }

    static func deviceName() -> String {
        return UIDevice.current.name
    }

    public static var screenStatusBarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0
            if #available(iOS 13.0, *) {
                let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            } else {
                statusBarHeight = UIApplication.shared.statusBarFrame.height
            }
            return statusBarHeight
    }

}
