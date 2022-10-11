//
//  HomeVC.swift
//  Clayful
//
//  Created by TajinderMohal on 13/05/22.
//

import UIKit
import ZendeskSDKMessaging
import ZendeskSDK

class HomeVC: UIViewController {
    
    @IBOutlet weak var vwRedCount: UIView!
    @IBOutlet weak var cnstBottomYellow: NSLayoutConstraint!
    @IBOutlet weak var imgVwLoader: UIImageView!
    @IBOutlet weak var lblLoaderTitle: UILabel!
    
    @IBOutlet weak var imgThreePerson: UIImageView!
    @IBOutlet weak var vwLetsChat: UIView!
    @IBOutlet weak var vwLogoutBottom: UIView!
    @IBOutlet weak var vwMessage: UIView!
    @IBOutlet weak var vwLoaderDetail: UIView!
    @IBOutlet weak var cnstHeightImgVwTop: NSLayoutConstraint!
    @IBOutlet weak var cnstTrailingVwMainDetail: NSLayoutConstraint!
    @IBOutlet weak var cnstLeadingVwMainDetail: NSLayoutConstraint!
    
    @IBOutlet weak var cnstBottomImgVwBottom: NSLayoutConstraint!
    @IBOutlet weak var cnstTrailingImgVwTop: NSLayoutConstraint!
    @IBOutlet weak var cnstLeadingImgVwTop: NSLayoutConstraint!
    
    @IBOutlet weak var cnstTop50: NSLayoutConstraint!
    @IBOutlet weak var cnstBottom40: NSLayoutConstraint!
    @IBOutlet weak var cnstBottomLast40: NSLayoutConstraint!
    @IBOutlet weak var cnstTopWahts40: NSLayoutConstraint!
    @IBOutlet weak var cnstBottomWhat7040: NSLayoutConstraint!
    
    var objHomeVM = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentConroller = self
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfNotificationCount), name: NSNotification.Name("NotificationCount"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfNotificationClear), name: NSNotification.Name("NotificationClear"), object: nil)
        if isComeFromLogin {
            imgVwLoader.image = UIImage.gifImageWithName(name: "safe-gif")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                    if UIDevice.current.orientation.isLandscape {
                        if isIpadView {
                            self.cnstBottomYellow.constant = ((self.view.frame.size.height - (self.view.frame.size.height/3)) - 100)
                        }
                    } else {
                        if isIpadView {
                            self.cnstBottomYellow.constant = ((self.view.frame.size.height - self.view.frame.size.height/3) - 50)
                        } else {
                            self.cnstBottomYellow.constant = (self.view.frame.size.height - (self.view.frame.size.height/3))
                        }
                    }
                    self.vwLoaderDetail.isHidden = true
                    self.vwMessage.isHidden = false
                    self.vwLogoutBottom.isHidden = false
                    self.vwLetsChat.alpha = 1
                    self.imgThreePerson.alpha = 1
                    self.view.layoutIfNeeded()
                }, completion: {
                    (value: Bool) in
                })
            }
        } else {
            chatControllerObj = Zendesk.instance?.messaging?.messagingViewController()
            vwLoaderDetail.isHidden = true
            vwMessage.isHidden = false
            vwLogoutBottom.isHidden = false
            vwLetsChat.alpha = 1
            imgThreePerson.alpha = 1
            if UIDevice.current.orientation.isLandscape {
                if isIpadView {
                    self.cnstBottomYellow.constant = ((self.view.frame.size.height - (self.view.frame.size.height/3)) - 100)
                }
            } else {
                if isIpadView {
                    self.cnstBottomYellow.constant = ((self.view.frame.size.height - self.view.frame.size.height/3) - 50)
                } else {
                    self.cnstBottomYellow.constant = (self.view.frame.size.height - (self.view.frame.size.height/3))
                }
            }
        }
        
        if UIDevice.current.orientation.isLandscape {
            debugPrint("Landscape")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = 280
                cnstTrailingVwMainDetail.constant = 280
                cnstLeadingImgVwTop.constant = 300
                cnstTrailingImgVwTop.constant = 300
                cnstBottomImgVwBottom.constant = -30
                setLandscapeUIMethod()
            }
        } else {
            debugPrint("Portrait")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = 120
                cnstTrailingVwMainDetail.constant = 120
                cnstLeadingImgVwTop.constant = 120
                cnstTrailingImgVwTop.constant = 120
                cnstBottomImgVwBottom.constant = -20
                setPortraitUIMethod()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            debugPrint("Landscape")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = 280
                cnstTrailingVwMainDetail.constant = 280
                cnstLeadingImgVwTop.constant = 300
                cnstTrailingImgVwTop.constant = 300
                self.cnstBottomYellow.constant = ((self.view.frame.size.width - (self.view.frame.size.width/3)) - 100)
                cnstBottomImgVwBottom.constant = -30
                setLandscapeUIMethod()
            }
        } else {
            debugPrint("Portrait")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = 120
                cnstTrailingVwMainDetail.constant = 120
                cnstLeadingImgVwTop.constant = 120
                cnstTrailingImgVwTop.constant = 120
                self.cnstBottomYellow.constant = ((self.view.frame.size.width - self.view.frame.size.width/3) - 50)
                cnstBottomImgVwBottom.constant = -20
                setPortraitUIMethod()
            } else {
                self.cnstBottomYellow.constant = (self.view.frame.size.height - self.view.frame.size.height/3)
            }
        }
    }
    
    @IBAction func actionBtnStartChat(_ sender: Any) {
        if isComeFromLogin {
            isComeFromLogin = false
            self.vwRedCount.isHidden = true
            UIApplication.shared.applicationIconBadgeNumber = 0
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            Messaging.delegate = self
            guard let chatContObj = Zendesk.instance?.messaging?.messagingViewController() else { return }
            chatControllerObj = chatContObj
            var navController = UINavigationController()
            navController = UINavigationController.init(rootViewController: chatContObj)
            navController.isNavigationBarHidden = false
            chatViewController = navController
            self.present(navController, animated: true, completion: nil)
        } else {
            self.vwRedCount.isHidden = true
            UIApplication.shared.applicationIconBadgeNumber = 0
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            Messaging.delegate = self
            guard let chatContObj = chatControllerObj else { return }
            var navController = UINavigationController()
            navController = UINavigationController.init(rootViewController: chatContObj)
            navController.isNavigationBarHidden = false
            chatViewController = navController
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionBtnLogout(_ sender: Any) {
        let controllerObj = getStoryBorad(.login).instantiateViewController(withIdentifier: "LogoutPopupVC") as! LogoutPopupVC
        controllerObj.callbackLogout = {
            DispatchQueue.main.async {
                Zendesk.instance?.logoutUser { result in
                    switch result {
                    case .success:
                        print("logoutUserSuccess:- ")
                    case .failure(let error):
                        print("logoutUserError:- ",error.localizedDescription)
                    }
                }
                accessTokenSaved = ""
                isLoginUser = false
                Zendesk.invalidate()
                RootControllerMethod.shared.rootWithoutDrawer(ContollerName.loginVC, storyBoardType: .login)
            }
        }
        self.present(controllerObj, animated: true, completion: nil)
    }
}

