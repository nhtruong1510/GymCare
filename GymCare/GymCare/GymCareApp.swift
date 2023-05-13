//
//  GymCareApp.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 12/02/2023.
//

import SwiftUI
import UIKit
//import zpdk

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        ZaloPaySDK.sharedInstance()?.initWithAppId(2554, uriScheme: "gymcare://app", environment: .sandbox)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NotificationCenter.default.post(name: .RELOAD_PAYMENT_SCREEN, object: nil)

        return true
//        return ZaloPaySDK.sharedInstance().application(app, open: url, sourceApplication:"vn.com.vng.zalopay", annotation: nil)
    }
}

@main
struct GymCareApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            Group {
                if ServiceSettings.shared.userInfo != nil {
                    TabbarView()
                        .preferredColorScheme(.light)
                } else {
                    ContentView()
                        .preferredColorScheme(.light)
                }
            }
            .onOpenURL { url in
                NotificationCenter.default.post(name: .RELOAD_PAYMENT_SCREEN, object: nil)

            }
            
        }
    }
}
