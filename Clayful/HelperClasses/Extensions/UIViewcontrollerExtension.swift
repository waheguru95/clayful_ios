//
//  UIViewcontrollerExtension.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit
import AVKit

extension UIViewController {
    
    func pushToNextController(_ identifier: String,storyBoardName:StoryBoardType,isAnimation: Bool) {
        let controllerObj = getStoryBorad(storyBoardName).instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(controllerObj, animated: isAnimation)
    }
    
    func pushToNextControllerWithTitle(_ identifier: String,storyBoardName:StoryBoardType,title: String,isAnimation: Bool) {
        let controllerObj = getStoryBorad(storyBoardName).instantiateViewController(withIdentifier: identifier)
        controllerObj.title = title
        self.navigationController?.pushViewController(controllerObj, animated: isAnimation)
    }
    
    func popViewController(_ isAnimation: Bool) {
        self.navigationController?.popViewController(animated: isAnimation)
    }
    
    func presentViewController(_ identifier: String,storyBoardName:StoryBoardType,isAnimation: Bool) {
        let controllerObj = getStoryBorad(storyBoardName).instantiateViewController(withIdentifier: identifier)
        self.present(controllerObj, animated: isAnimation, completion: nil)
    }
    
    func presentViewControllerWithTitle(_ identifier: String,storyBoardName:StoryBoardType,title: String,isAnimation: Bool) {
        let controllerObj = getStoryBorad(storyBoardName).instantiateViewController(withIdentifier: identifier)
        controllerObj.title = title
        self.present(controllerObj, animated: isAnimation, completion: nil)
    }
    
    func dismissViewController(_ isAnimation: Bool) {
        self.dismiss(animated: isAnimation, completion: nil)
    }
    
    //MARK:- Display Toast Methos
    func displayAlertMessage(_ message: String) {
        let alert = UIAlertController(title: AppInfo.AppName, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = .black
        let action = UIAlertAction(title: AppAlerts.titleValue.ok, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Display Toast Methos
    func displayAlertMessageTitle(_ title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = .black
        let action = UIAlertAction(title: AppAlerts.titleValue.ok, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Display Toast Methos with title
    func displayAlertMessageWithTitle(_ info: String,  _ message: String) {
        let alert = UIAlertController(title: info, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = .black
        let action = UIAlertAction(title: AppAlerts.titleValue.ok, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Display Toast Methos
    func displayAlertMessageWithOk(_ message: String,completion:@escaping() -> Void) {
        let alert = UIAlertController(title: AppInfo.AppName, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = .black
        let action = UIAlertAction(title: AppAlerts.titleValue.ok, style: .default, handler: { (_) in
            completion()
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Display Toast Methos
    func displayAlertMessageWithOkAndCancel(_ title:String,message: String,button: String,completion:@escaping(_ isSuccess:Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = .black
        let actionOk = UIAlertAction(title: button, style: .default, handler: { (_) in
            completion(true)
        })
        let actionCancel = UIAlertAction(title: button == AppAlerts.titleValue.yes ? AppAlerts.titleValue.no :  AppAlerts.titleValue.cancel, style: .default, handler: { (_) in
            completion(false)
        })
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- UTC To Local Convert Method
    func UTCToLocal(_ UTCDateString: String,backendFormat:String,needFormat:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = backendFormat //"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale.current
        let UTCDate = dateFormatter.date(from: UTCDateString)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = needFormat
        if UTCDate != nil {
            let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
            return UTCToCurrentFormat
        } else {
            return ""
        }
    }
    
    //MARK:- Get Date And Time In String Method
    func getDateAndTimeInStr(getDate:String,backendFormat:String,needDateFormat:String,needTimeFormat:String) -> (String,String) {
        var resultDateInStr = String(),resultTimeInStr = String()
        if getDate != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = backendFormat//"yyyy-MM-dd hh:mm a"
            let dateInStr = dateFormatter.date(from: getDate)
            
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = needDateFormat//"yyyy-MM-dd"
            if dateInStr != nil {
                resultDateInStr = dateFormatter1.string(from: dateInStr!)
            }
            
            dateFormatter1.dateFormat = needTimeFormat//"hh:mm a"
            let timeInStr = dateFormatter.date(from: getDate)
            if timeInStr != nil {
                resultTimeInStr = dateFormatter1.string(from: timeInStr!)
            }
        }
        return (resultDateInStr,resultTimeInStr)
    }
    
    //MARK:- Get String From Date Method
    func getStringFromDate(date: Date,needFormat: String) -> String {
        var dateStr = String()
        if needFormat != "" {
            let formatter = DateFormatter()
            formatter.dateFormat = needFormat
            let locale = Locale.current
            formatter.locale = locale
            dateStr = formatter.string(from: date)
        }
        return dateStr
    }
    
    //MARK:- Get Date From String Method
    func getDateFromSting(string: String,stringFormat: String) -> Date {
        var date = Date()
        if string != "" {
            let formatter = DateFormatter()
            formatter.dateFormat = stringFormat
            let dateInDate = formatter.date(from: string)
            if dateInDate != nil {
                date = dateInDate!
            }
        }
        return date
    }
    
    func setPlaceholderColor(textField : UITextField) {
        let placeholder = NSAttributedString(string: (textField.attributedPlaceholder?.string)!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1.0, alpha: 0.7)])
        textField.attributedPlaceholder = placeholder
        textField.tintColor = .white
    }
    
    func isNull(_ text: String?) -> Bool {
        if text != nil {
            if ((text?.count ?? 0) == 0) || text == "<null>" || text == "(null)" || (text == "") {
                return true
            } else {
                return false
            }
        }
        return true
    }
    
}
