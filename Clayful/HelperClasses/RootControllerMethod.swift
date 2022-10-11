//
//  RootControllerMethod.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit

class RootControllerMethod {
    
    static var shared: RootControllerMethod {
        return RootControllerMethod()
    }
    
    fileprivate init(){}
    
    //MARK:- Set Root Without Drawer Method
    func rootWithoutDrawer(_ identifier: String,storyBoardType:StoryBoardType) {
        let blankController = getStoryBorad(storyBoardType).instantiateViewController(withIdentifier: identifier)
        var homeNavController:UINavigationController = UINavigationController()
        homeNavController = UINavigationController.init(rootViewController: blankController)
        homeNavController.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = homeNavController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
