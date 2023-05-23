//
//  GymCareApp.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 12/02/2023.
//

import SwiftUI
import UIKit
import BackgroundTasks

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    var topMost: UIViewController? {
        var topController = window?.rootViewController

        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }

        return topController
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        firebase(application)
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.BGTask.refresh", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NotificationCenter.default.post(name: .RELOAD_PAYMENT_SCREEN, object: nil)

        return true
//        return ZaloPaySDK.sharedInstance().application(app, open: url, sourceApplication:"vn.com.vng.zalopay", annotation: nil)
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("background")
        let viewModel = HealthViewModel()
        viewModel.loadInfoHealth()
        completionHandler(.newData)
    }
    
    
    
    func scheduleAppRefresh() {

        let request = BGProcessingTaskRequest(identifier: "com.example.BGTask.refresh")
        request.requiresNetworkConnectivity = false
        request.requiresExternalPower = false

        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }

    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh()
        
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        
        // increment instead of a fixed number
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "bgtask")+1, forKey: "bgtask")

        task.setTaskCompleted(success: true)
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
