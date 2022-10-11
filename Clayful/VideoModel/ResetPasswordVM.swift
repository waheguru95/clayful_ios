//
//  ResetPasswordVM.swift
//  Clayful
//
//  Created by netset on 20/05/22.
//

import UIKit

class ResetPasswordVM {
    
    var popoverOptions: [PopoverOption] = [
        .type(.up),
        .blackOverlayColor(UIColor(white: 0.0, alpha: 0.4))
    ],
    popTip = Popover(),
    emailStr = String()
    
    //MARK:- Hit Reset Password Api Method
    func hitResetPasswordApiMethod(_ request: ResetPassword.Request,viewCont:UIViewController,completion:@escaping() -> Void) {
        let param = [
            "newPassword":"\(request.newPassword ?? "")",
            "token":"\(request.codeStr ?? "")"
        ] as [String:AnyObject]
        WebServices.shared.postData(Apis.resetPassword, params: param, showIndicator: true, methodType: .post, viewCont: viewCont) { response in
            if response.isSuccess {
                completion()
            } else {
                viewCont.displayAlertMessage(response.message)
            }
        }
    }
}
