//
//  NotificationONOffVC.swift
//  Clayful
//
//  Created by netset on 06/08/22.
//

import UIKit

class NotificationONOffVC: UIViewController {

    @IBOutlet weak var lblDescript: UILabel!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var cnstTrailingBtnNo: NSLayoutConstraint!
    @IBOutlet weak var cnstLeadingBtnNo: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        if UIDevice.current.orientation.isLandscape {
            debugPrint("Landscape")
            if isIpadView {
                cnstTrailingBtnNo.constant = 180
                cnstLeadingBtnNo.constant = 180
            }
        } else {
            debugPrint("Portrait")
            if isIpadView {
                cnstTrailingBtnNo.constant = 100
                cnstLeadingBtnNo.constant = 100
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            debugPrint("Landscape")
            if isIpadView {
                cnstTrailingBtnNo.constant = 180
                cnstLeadingBtnNo.constant = 180
            }
        } else {
            debugPrint("Portrait")
            if isIpadView {
                cnstTrailingBtnNo.constant = 100
                cnstLeadingBtnNo.constant = 100
            }
        }
    }

    @IBAction func actionBtnYes(_ sender: Any) {
        appDelegate.registerForPushNotifications()
    }
    
    
    @IBAction func actionBtnNo(_ sender: Any) {
        RootControllerMethod.shared.rootWithoutDrawer(ContollerName.loginVC, storyBoardType: .login)
    }
    
}
extension NotificationONOffVC {
    
    func prepareUI() {
        objPushNotifications = self
        btnYes.setTitleFont("Yes, turn on notifications", fontName: AppFontName.mulishExtraBold, size: isIpadView ? 27 : 19)
        btnNo.setTitleFont("no thanks", fontName: AppFontName.mulishMedium, size: isIpadView ? 22 : 15)
        let formatStr = NSMutableAttributedString()
        formatStr.attributedString(str1: "\(AppAlerts.titleValue.notificationDes1)\n\(AppAlerts.titleValue.notificationDes2)", color: AppColor.appBlueColor, font: UIFont(name: AppFontName.mulishMedium, size: isIpadView ? 27 : 19)!, lineHeight: 1.3, align: TextAlign.center)
        lblDescript.attributedText = formatStr
    }
}

extension NotificationONOffVC: PushNotificationsDeletegate {
    
    func notificationEnableDisable(_ isEnable: Bool) {
        isFirstTimeLaunch = true
        RootControllerMethod.shared.rootWithoutDrawer(ContollerName.loginVC, storyBoardType: .login)
    }

}
