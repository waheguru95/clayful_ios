//
//  AppAlerts.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit

class AppAlerts {
    static var titleValue: AppAlerts {
        return AppAlerts()
    }
    fileprivate init(){}
    
    //MARK:- App Common Titles
    var chooseImage = "Choose Image"
    var camrea = "Camera"
    var ok = "Ok"
    var cancel = "Cancel"
    var connectionProblem = "Connection Problem"
    var setting = "Setting"
    var error = "Error!"
    var alert = "Alert"
    var yes = "Yes"
    var no = "No"
    
    //App Alert
    
    //MARK:- App Common Alerts
    var pleaseReviewyournetworksettings = "Please Review your network settings"
    var checkInternet = "Please check your internet connection"
    var ErrorUnabletoencodeJSONResponse = "Error: Unable to encode JSON Response"
    var serverError = "Server error, Please try again.."
    var serverNotResponding = "Server not responding"
    
    //App Alert
    var emailEmpty = "Email address field can't be empty"
    var emailNotValid = "Entered email address is not valid"
    var passwordEmpty = "Password field can't be empty"
    var logoutMessage = "Are you sure you want to logout?"
    var codeEmpty = "Code field can't be empty"
    var newPasswordEmpty = "New password field can't be empty"
    var confirmPasswordEmpty = "Confirm password field can't be empty"
    var confirmNotMatch = "Passwords don’t match"
    var passwordMinimum8Limit = "Password must be minimum 8 characters"
    var forgotPasswordDescript = "Enter the email asociated with your account, and we’ll send you an email with instructions to reset your password."
    var loginDescrip1 = "Login with the account"
    var loginDescrip2 = "you created at school"
    var welcomeBack = "" //"Welcome back ✨"
    var resetDescript = "Please enter your 6-digit one-time code. Then create and confirm your password."
    var notificationDes1 = "Notifications ensure you can see"
    var notificationDes2 = "new messages from coaches."
    
}
