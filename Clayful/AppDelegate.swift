//
//  AppDelegate.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit
import ZendeskSDKMessaging
import ZendeskSDK
import CioTracking
import CioMessagingPushAPN
import Heap

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Heap.initialize("1321035351")
        if (launchOptions?[UIApplication.LaunchOptionsKey.url]) != nil  {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.handleDeepLinkingMethod()
            }
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.absoluteString.contains("clayful://") {
            handleDeepLinkingMethod()
        }
        return true
    }
    
    func handleDeepLinkingMethod() {
        if isFirstTimeLaunch {
            if isLoginUser && accessTokenSaved != "" {
                let controller = CommonMethod.shared.getCurrentViewController()
                if controller.isKind(of: HomeVC.self) {
                    NotificationCenter.default.post(name: NSNotification.Name("NotificationClear"), object: nil, userInfo: nil)
                }
            } else {
                RootControllerMethod.shared.rootWithoutDrawer(ContollerName.loginVC, storyBoardType: .login)
            }
        } else {
            RootControllerMethod.shared.rootWithoutDrawer(ContollerName.notificationONOffVC, storyBoardType: .login)
        }
    }
    
}

extension AppDelegate {
    
    func registerForPushNotifications() {
        CustomerIO.initialize(siteId: CustomerIOInfo.siteId, apiKey: CustomerIOInfo.apiKey)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { allowed, error in
            guard allowed else {
                debugPrint("No Enables")
                DispatchQueue.main.async {
                    objPushNotifications?.notificationEnableDisable(false)
                }
                return
            }
            debugPrint("Yes Enables")
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
                objPushNotifications?.notificationEnableDisable(true)
            }
        }
        CustomerIO.config { $0.logLevel = .debug }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        deviceTokenSaved = token
        //MessagingPush.shared.registerDeviceToken(apnDeviceToken: deviceToken)
        //MessagingPush.shared.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        PushNotifications.updatePushNotificationToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("Unable to register for remote notifications: \(error.localizedDescription)")
        MessagingPush.shared.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        debugPrint("PushUserInfo:- ",userInfo as NSDictionary)
        let shouldBeDisplayed = PushNotifications.shouldBeDisplayed(userInfo)
        let handled = MessagingPush.shared.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
        if !handled {
        }
        switch shouldBeDisplayed {
        case .messagingShouldDisplay:
            if accessTokenSaved != "" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    PushNotifications.handleTap(userInfo) { viewController in
//                        var navController = UINavigationController()
//                        navController = UINavigationController.init(rootViewController: chatControllerObj != nil ? chatControllerObj! : viewController!)
//                        navController.isNavigationBarHidden = false
//                        chatViewController = navController
//                        currentConroller.present(navController, animated: true, completion: nil)
                        UIApplication.shared.applicationIconBadgeNumber = 0
                        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                        NotificationCenter.default.post(name: NSNotification.Name("NotificationClear"), object: nil, userInfo: nil)
                    }
                }
            } else {
                UIApplication.shared.applicationIconBadgeNumber = 0
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            }
        case .messagingShouldNotDisplay:
            break
        case .notFromMessaging:
            break
        @unknown default:
            break
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping(UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        debugPrint("PushUserInfo:- ",userInfo as NSDictionary)
        let shouldBeDisplayed = PushNotifications.shouldBeDisplayed(userInfo)
        switch shouldBeDisplayed {
        case .messagingShouldDisplay:
            if accessTokenSaved != "" {
                NotificationCenter.default.post(name: NSNotification.Name("NotificationCount"), object: nil, userInfo: nil)
                if #available(iOS 14.0, *) {
                    completionHandler([.banner, .sound, .badge])
                } else {
                    completionHandler([.alert, .sound, .badge])
                }
            }
        case .messagingShouldNotDisplay:
            completionHandler([])
        case .notFromMessaging:
            completionHandler([.alert, .sound])
        @unknown default: break
        }
    }
    
}
