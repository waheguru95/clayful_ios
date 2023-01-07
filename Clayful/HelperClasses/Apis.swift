//
//  Apis.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import Foundation

enum ServerUrl {

    //static let apiServerUrl = "https://api.memberstack.io/"
    static let apiServerUrl = "https://client.memberstack.com/auth/"
}

enum Apis {
   
//    static let signIn = ServerUrl.apiServerUrl + "member/login"
//    static let forgotPassword = ServerUrl.apiServerUrl + "member/forgot-password"
//    static let resetPassword = ServerUrl.apiServerUrl + "member/password-reset"
    static let signIn = ServerUrl.apiServerUrl + "login/"
    static let forgotPassword = ServerUrl.apiServerUrl + "send-reset-password-email/"
    static let resetPassword = ServerUrl.apiServerUrl + "reset-password/"
    
    static let userAuthorization = "http://34.27.91.26:8000/api/get_token/"
    //"https://sleepy-shelf-99425.herokuapp.com/api/get_token/"
}


