//
//  ForgotPasswordVM.swift
//  Clayful
//
//  Created by TajinderMohal on 14/05/22.
//

import UIKit

class ForgotPasswordVM {
    
    //MARK:- Hit Forgot Password Api Method
    func hitForgotPasswordApiMethod(_ request: ForgotPassword.Request,viewCont:UIViewController,completion:@escaping() -> Void) {
        let param = [
            "email":"\(request.email ?? "")"
        ] as [String:AnyObject]
        WebServices.shared.postData(Apis.forgotPassword, params: param, showIndicator: true, methodType: .post, viewCont: viewCont) { response in
            if response.isSuccess {
                completion()
            } else {
                viewCont.displayAlertMessage(response.message)
            }
        }
    }
    
}
