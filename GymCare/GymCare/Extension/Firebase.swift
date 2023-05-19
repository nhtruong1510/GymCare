//
//  Firebase.swift
//  FirebaseCloudMessaging
//

import Firebase
import FirebaseMessaging
import UserNotifications
import SwiftUI

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    // Add this function to application(didFinishLaunchingWithOptions) in AppDelegate
    func firebase(_ application: UIApplication) {
        FirebaseApp.configure()
        firebaseNoti(application)
    }

    func firebaseNoti(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings = .init(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }

    func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Your apns token is stored in token
        var token = ""
        for tokenIndex in 0 ..< deviceToken.count {
            token += String(format: "%02.2hhx", deviceToken[tokenIndex] as CVarArg)
        }

        // Debug
        print("didRegisterForRemoteNotificationsWithDeviceToken", token)
        // With swizzling disabled you must set the APNs token here.
        Messaging.messaging().apnsToken = deviceToken
        // Messaging.messaging().setAPNSToken(deviceToken, type: .sandbox)
    }

    func messaging(_: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // Debug
        print("messaging(messaging,didRefreshRegistrationToken)", fcmToken as Any)
    }

    func application(_: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.

        // Debug
        processNotification(userInfo)
        print("application(application,didReceiveRemoteNotification)", userInfo)
    }

    // NOTE
    // Fire if notification has content_available: true
    // iOS  9- : Fire if app active or tap on notification
    //
    // content_available: true && title != "" && body != ""
    // iOS 10+: If user contiune tap on notification userNotificationCenter(didReceive,withCompletionHandler) will fire
    // iOS  9-: Fire again if tap on notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.

        print("application(application,didReceiveRemoteNotification,fetchCompletionHandler)", userInfo)
        completionHandler(UIBackgroundFetchResult.newData)

        let state = application.applicationState
        switch state {
        case .inactive:
            application.applicationIconBadgeNumber += application.applicationIconBadgeNumber
        case .background:
            print("Background")
            // update badge count here
            application.applicationIconBadgeNumber += application.applicationIconBadgeNumber
        case .active:
            application.applicationIconBadgeNumber += application.applicationIconBadgeNumber
        @unknown default:
            fatalError()
        }
    }

    // NOTE
    // Fire when app active on iOS 10+
//    @available(iOS 10.0, *)
    func userNotificationCenter(_: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        // Debug
        print("userNotificationCenter(willPresent,withCompletionHandler)", notification.request.content.userInfo)
        // NOTE
        // Your data is stored in here!
        // notification.request.content.userInfo

        // Uncomment if wanna show notification in app
        // If user contiune tap on notification userNotificationCenter(didReceive,withCompletionHandler) will fire
        completionHandler([.alert, .badge, .sound])
    }

    // NOTE
    // Fire when tap on notification on iOS 10+
//    @available(iOS 10.0, *)
    func userNotificationCenter(_: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void)
    {
        // Debug
        print("userNotificationCenter(didReceive,withCompletionHandler)", response.notification.request.content.userInfo)
        processNotification(response.notification.request.content.userInfo)
        // NOTE
        // Your data is stored in here!
        // response.notification.request.content.userInfo
        completionHandler()
    }

    func processNotification(_ userInfo: [AnyHashable: Any]) {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            ServiceSettings.shared.isPushRemote = true
            if ServiceSettings.shared.userInfo != nil {
                let swiftUIView = TabbarView().preferredColorScheme(.light)
                let hostingController = UIHostingController(rootView: swiftUIView)
                hostingController.modalPresentationStyle = .fullScreen
                topController.present(hostingController, animated: false, completion: nil)
            }
        }
    }
}
