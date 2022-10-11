//
//  Constants.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit

enum AppInfo {
    static let AppName = "Clayful"
    static let DeviceName =  UIDevice.current.name
    static let DeviceId =  UIDevice.current.identifierForVendor!.uuidString
    static let memberStackId = "ebc2f68bf336f91bebf681d0ec33735b"
    static let appUrlHeader = "https://app.clayfulhealth.com"
}

enum AppColor {
    
    static var appBlueColor = UIColor(red: 31/255, green: 50/255, blue: 99/255, alpha: 1.0)
    static var themeColor = UIColor(red: 232/255, green: 242/255, blue: 254/255, alpha: 1.0)
   
}

//MARK:- Header Param
enum Param {
    static let origin = "Origin"
}

// MARK: - STORYBOARD TYPES
enum StoryBoardType: String {
    case login = "Main"
}

enum ZendeskInfo {
    static let channelKey = "eyJzZXR0aW5nc191cmwiOiJodHRwczovL2NsYXlmdWwuemVuZGVzay5jb20vbW9iaWxlX3Nka19hcGkvc2V0dGluZ3MvMDFHMzlEOVlDQTZGNjA0MzIyTlI4U1Q3NkcuanNvbiJ9"
}
enum CustomerIOInfo {
    static let siteId = "24c64fcc43414fbae214"
    static let apiKey = "ff5da16dbb7b3f4eece1"
}

enum ContollerName {
    static let loginVC = "LoginVC"
    static let homeVC = "HomeVC"
    static let forgotPasswordVC = "ForgotPasswordVC"
    static let resetPasswordVC = "ResetPasswordVC"
    static let passwordChangedSuccessVC = "PasswordChangedSuccessVC"
    static let feedbackPopUpVC = "FeedbackPopUpVC"
    static let loaderVC = "LoaderVC"
    static let notificationONOffVC = "NotificationONOffVC"
}

enum CellClassName {
    static let languageCVC = "LanguageCVC"
}

enum DateFormatStyle {
    static let YYYYMMDD = "YYYY-MM-dd"
    static let DDMMMMYYYY = "dd MMMM,yyyy"
    static let HHMMA = "hh:mm a"
    static let HHMM = "HH:mm"
    static let EEEE = "EEEE"
    static let EE = "EE"
    static let dd = "dd"
    static let YYYYMMDDHHMMSS = "yyyy-MM-dd HH:mm:ss"
}

enum AppFontName {
    static let mulishExtraBold = "Mulish-ExtraBold"
    static let mulishRegular = "Mulish-Regular"
    static let mulishMedium = "Mulish-Medium"
}

enum TextAlign {
    static let center = "C"
    static let left = "L"
}

struct ResponseHandle {
        var data = Data(),
        JSON = NSDictionary(),
        message = String(),
        isSuccess = Bool(),
        statusCode = Int()
}
