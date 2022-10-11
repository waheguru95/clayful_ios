//
//  UserDefaultsMethod.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import Foundation

//MARK:- Save Token In Database
var isLoginUser: Bool {
    get {
        return UserDefaults.standard.value(forKey: "is_login") as? Bool ?? false
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: "is_login")
        UserDefaults.standard.synchronize()
    }
}

//MARK:- Save Token In Database
var accessTokenSaved: String {
    get {
        return UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: "accessToken")
    }
}

//MARK:- Save Device Token In Database
var deviceTokenSaved: String {
    get {
        return UserDefaults.standard.value(forKey: "device_token") as? String ?? ""
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: "device_token")
    }
}

//MARK:- Save Login In Database
var userLoginId: String {
    get {
        return UserDefaults.standard.value(forKey: "user_login_id") as? String ?? ""
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: "user_login_id")
    }
}

//MARK:- Save First Time In Database
var isFirstTimeLaunch: Bool {
    get {
        return UserDefaults.standard.value(forKey: "is_first_time_launch") as? Bool ?? false
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: "is_first_time_launch")
        UserDefaults.standard.synchronize()
    }
}
