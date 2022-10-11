//
//  RequestModel.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit

//MARK:- Login Request Model
enum Login {
    struct Request {
        var email: String?,
            password: String?
    }
}

//MARK:- ForgotPassword Request Model
enum ForgotPassword {
    struct Request {
        var email: String?
    }
}

//MARK:- ResetPassword Request Model
enum ResetPassword {
    struct Request {
        var codeStr: String?,
            newPassword: String?,
            confirmPassword: String?
    }
}
