//
//  LoginVM.swift
//  Clayful
//
//  Created by TajinderMohal on 13/05/22.
//

import UIKit

class LoginVM {
    
    var objUserDetailModel = UserDetailModel(),
    jwtToken = String()
    
    //MARK:- Hit Sign In Api Method
    func hitSignInApiMethod(_ request: Login.Request,viewCont:UIViewController,completion:@escaping(_ isSuccess:Bool,_ message: String) -> Void) {
        let param = [
            "email":"\(request.email ?? "")",
            "password":"\(request.password ?? "")",
        ] as [String:AnyObject]
        WebServices.shared.postData(Apis.signIn, params: param, showIndicator: false, methodType: .post, viewCont: viewCont) { response in
            if response.isSuccess {
                if let dataDict = response.JSON["data"] as? NSDictionary {
                    self.objUserDetailModel.setData(dataDict)
                    isLoginUser = true
                    accessTokenSaved = self.objUserDetailModel.token
                    userLoginId = self.objUserDetailModel.userId
                }
                completion(true,"")
            } else {
                completion(false,response.message)
            }
        }
    }
    
    //MARK:- Hit User Authorization Api Method
    func hitUserAuthorizationApiMethod(_ viewCont:UIViewController,completion:@escaping() -> Void) {
        let param = [
            "external_id":"\(userLoginId)",
        ] as [String:AnyObject]
        WebServices.shared.postData(Apis.userAuthorization, params: param, showIndicator: false, methodType: .post, viewCont: viewCont) { response in
            if response.isSuccess {
                if let token = response.JSON["token"] as? String {
                    self.jwtToken = token
                    completion()
                }
            } else {
                viewCont.displayAlertMessage(response.message)
            }
        }
    }
    
}

