//
//  CommonMethod.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit
import NVActivityIndicatorView

class CommonMethod {
    
    static var shared: CommonMethod {
        return CommonMethod()
    }
    fileprivate init(){}
    
    //MARK:- Check Valid Email Method
    func isValidEmail(_ testStr:String) -> Bool  {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return (testStr.range(of: emailRegEx, options:.regularExpression) != nil)
    }
    
    func isValidateEmail(with email: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    //MARK:- Show Activity Indicator Method
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        }
    }

    //MARK:- Hide Activity Indicator Method
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }
    
    //MARK:- Display alert Methods
    func showAlertMessage(_ message: String) {
        let alert = UIAlertController(title: AppInfo.AppName, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = .black
        let action = UIAlertAction(title: AppAlerts.titleValue.ok, style: .default, handler: nil)
        alert.addAction(action)
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Display Alert with ok and cancel Methods
    func showAlertWithCancelAndOkAction(okTitle: String? = nil, message: String, onComplete:@escaping (() -> Void), onCancel:@escaping (() -> Void)) {
        let alert = UIAlertController(title: AppInfo.AppName, message: message, preferredStyle: .alert)
        alert.view.tintColor = .black
        alert.addAction(UIAlertAction(title: okTitle != nil ? okTitle : "Ok", style: .default, handler: { (_) in
            onComplete()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            onCancel()
        }))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Open Setting Of App
    func openSettingApp() {
        let settingAlert = UIAlertController(title: AppAlerts.titleValue.connectionProblem, message: AppAlerts.titleValue.checkInternet, preferredStyle: UIAlertController.Style.alert)
        settingAlert.view.tintColor = .black
        let okAction = UIAlertAction(title: AppAlerts.titleValue.cancel, style: UIAlertAction.Style.default, handler: nil)
        settingAlert.addAction(okAction)
        let openSetting = UIAlertAction(title: AppAlerts.titleValue.setting, style:UIAlertAction.Style.default, handler:{ (action: UIAlertAction!) in
            let url:URL = URL(string: UIApplication.openSettingsURLString)!
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                                            (success) in })
            } else {
                guard UIApplication.shared.openURL(url) else {
                    CommonMethod.shared.showAlertMessage(AppAlerts.titleValue.pleaseReviewyournetworksettings)
                    return
                }
            }
        })
        settingAlert.addAction(openSetting)
        UIApplication.shared.windows.first?.rootViewController?.present(settingAlert, animated: true, completion: nil)
    }
    
    //MARK:- Open Permision Setting Alert Method
    func openPermisionSettingAlert(_ titleVal: String) {
        let settingAlert = UIAlertController(title: AppInfo.AppName, message: titleVal, preferredStyle: UIAlertController.Style.alert)
        settingAlert.view.tintColor = .black
        let okAction = UIAlertAction(title: AppAlerts.titleValue.cancel, style: UIAlertAction.Style.default, handler: nil)
        settingAlert.addAction(okAction)
        let openSetting = UIAlertAction(title: AppAlerts.titleValue.setting, style:UIAlertAction.Style.default, handler:{ (action: UIAlertAction!) in
            let url:URL = URL(string: UIApplication.openSettingsURLString)!
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                                            (success) in })
            } else {
                guard UIApplication.shared.openURL(url) else {
                    CommonMethod.shared.showAlertMessage(titleVal)
                    return
                }
            }
        })
        settingAlert.addAction(openSetting)
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController?.present(settingAlert, animated: true, completion: nil)
        }
    }
    
    func getCurrentViewController() -> UIViewController {
        let newVC = UIViewController()
        if let window = UIApplication.shared.delegate?.window {
            if let viewController = window?.rootViewController {
                return findTopViewController(viewController: viewController)
            }
        }
        return newVC
    }
    
    func findTopViewController(viewController : UIViewController) -> UIViewController {
        if viewController is UITabBarController {
            let controller = viewController as! UITabBarController
            return findTopViewController(viewController: controller.selectedViewController!)
        }
        else if viewController is UINavigationController {
            let controller = viewController as! UINavigationController
            return findTopViewController(viewController: controller.visibleViewController!)
        }
        return viewController
    }

}
