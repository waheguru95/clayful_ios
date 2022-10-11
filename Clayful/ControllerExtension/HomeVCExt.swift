//
//  HomeVCExt.swift
//  Clayful
//
//  Created by TajinderMohal on 14/05/22.
//

import UIKit
import ZendeskSDKMessaging
import ZendeskSDK

extension HomeVC {
    
    @objc func methodOfNotificationCount(_ notification: Notification) {
        vwRedCount.isHidden = false
    }
    
    @objc func methodOfNotificationClear(_ notification: Notification) {
        Messaging.delegate = self
        if isComeFromLogin {
            isComeFromLogin = false
            self.vwRedCount.isHidden = true
            UIApplication.shared.applicationIconBadgeNumber = 0
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            Messaging.delegate = self
            guard let chatContObj = Zendesk.instance?.messaging?.messagingViewController() else { return }
            chatControllerObj = chatContObj
            var navController = UINavigationController()
            navController = UINavigationController.init(rootViewController: chatContObj)
            navController.isNavigationBarHidden = false
            chatViewController = navController
            self.present(navController, animated: true, completion: nil)
        } else {
            self.vwRedCount.isHidden = true
            UIApplication.shared.applicationIconBadgeNumber = 0
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            Messaging.delegate = self
            guard let chatContObj = chatControllerObj else { return }
            var navController = UINavigationController()
            navController = UINavigationController.init(rootViewController: chatContObj)
            navController.isNavigationBarHidden = false
            chatViewController = navController
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    func setLandscapeUIMethod() {
        cnstTop50.constant = 40
        cnstBottom40.constant = 30
        cnstBottomLast40.constant = 35
        cnstTopWahts40.constant = 35
        cnstBottomWhat7040.constant = 40
        cnstHeightImgVwTop.constant = 200
    }
    
    func setPortraitUIMethod() {
        cnstTop50.constant = 50
        cnstBottom40.constant = 40
        cnstBottomLast40.constant = 40
        cnstTopWahts40.constant = 40
        cnstBottomWhat7040.constant = 70
        cnstHeightImgVwTop.constant = 230
    }
}

extension HomeVC: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, shouldHandleURL url: URL, from source: URLSource) -> Bool {
        print("shouldHandleURL:- ")
        let urlString = url.absoluteString
        if urlString.contains("clayful.co/feedback") {
            let controllerObj = getStoryBorad(.login).instantiateViewController(withIdentifier: ContollerName.feedbackPopUpVC) as! FeedbackPopUpVC
            controllerObj.linkUrlStr = "https://n1tn06od1jc.typeform.com/to/vJGzPwIx#id=\(userLoginId)"
            chatViewController.present(controllerObj, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    
}

