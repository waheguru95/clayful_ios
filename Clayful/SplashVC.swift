//
//  SplashVC.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
// 

import UIKit
import IQKeyboardManagerSwift
import ZendeskSDKMessaging
import ZendeskSDK
import ZendeskCoreSDK

class SplashVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        Zendesk.initialize(withChannelKey: ZendeskInfo.channelKey,messagingFactory: DefaultMessagingFactory()) { result in
            if case let .failure(error) = result {
                debugPrint("Messaging did not initialize.\nError: \(error.localizedDescription)")
            }
        }
        sleep(3)
        if isFirstTimeLaunch {
            if isLoginUser && accessTokenSaved != "" {
                isComeFromLogin = false
                RootControllerMethod.shared.rootWithoutDrawer(ContollerName.homeVC, storyBoardType: .login)
            } else {
                RootControllerMethod.shared.rootWithoutDrawer(ContollerName.loginVC, storyBoardType: .login)
            }
        } else {
            RootControllerMethod.shared.rootWithoutDrawer(ContollerName.notificationONOffVC, storyBoardType: .login)
        }
    }
    
    
}
