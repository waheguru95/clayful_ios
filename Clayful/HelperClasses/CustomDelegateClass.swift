//
//  CustomDelegateClass.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit

protocol PushNotificationsDeletegate {
    func notificationEnableDisable(_ isEnable:Bool)
}
var objPushNotifications:PushNotificationsDeletegate?
