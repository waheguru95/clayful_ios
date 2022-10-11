//
//  CommonFunc&Varibales.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit

//MARK:- Common Globel Variables
let appDelegate = UIApplication.shared.delegate as! AppDelegate
var currentConroller = UIViewController()
var isComeFromLogin = Bool()
var chatViewController = UIViewController()
var chatControllerObj: UIViewController?

var getAppVersion: String {
    get {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
}

var isIpadView:Bool {
    get {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return false
        } else {
            return true
        }
    }
}

//MARK:- App Header
func headers() ->  [String:String] {
    let headers = [
        Param.origin:AppInfo.appUrlHeader
    ]
    return headers
}

//MARK:- App Font Method
func AppFont(_ name: String,size:CGFloat) -> UIFont {
    return UIFont(name: name, size: size)!
}

//MARK:- Storyboard Object Method
func getStoryBorad(_ storyBoardType: StoryBoardType) -> UIStoryboard {
    return UIStoryboard.init(name: storyBoardType.rawValue, bundle: nil)
}

