//
//  UserDetailModel.swift
//  Clayful
//
//  Created by TajinderMohal on 13/05/22.
//

import Foundation

struct UserDetailModel {
    
    var email = String(),
    token = String(),
    accountId = String(),
    userId = String(),
    accountName = String(),
    role = String(),
    id = String()
    
    mutating func setData(_ data:NSDictionary) {
        if let tokensDict = data["tokens"] as? NSDictionary {
            token = tokensDict["accessToken"] as? String ?? ""
        }
        if let memberDict = data["member"] as? NSDictionary {
            if let authDict = memberDict["auth"] as? NSDictionary {
                email = authDict["email"] as? String ?? ""
            }
            if let customFieldsDict = memberDict["customFields"] as? NSDictionary {
                accountId = customFieldsDict["accountId"] as? String ?? ""
                accountName = customFieldsDict["accountName"] as? String ?? ""
                role = customFieldsDict["role"] as? String ?? ""
                userId = customFieldsDict["userId"] as? String ?? ""
            }
            id = memberDict["customFields"] as? String ?? ""
        }
    }
    
}
