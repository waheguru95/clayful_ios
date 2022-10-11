//
//  LoginVC.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit
import ZendeskSDKMessaging
import ZendeskSDK
import ZendeskCoreSDK
import CioTracking
import CioMessagingPushAPN
import Heap

class LoginVC: UIViewController {
    
    @IBOutlet weak var imgVwLandscaple: UIImageView!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var cnstHeightLblPasswordError: NSLayoutConstraint! // 30
    @IBOutlet weak var cnstHeightLblEmailError: NSLayoutConstraint! //30
    @IBOutlet weak var lblPasswordError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var cnstBottomVwYellow: NSLayoutConstraint!
    @IBOutlet weak var imgVwLoader: UIImageView!
    @IBOutlet weak var vwYellow: UIView!
    @IBOutlet weak var vwLoaderInfo: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var scrollVwContent: UIScrollView!
    @IBOutlet weak var cnstTrailingVwMainDetail: NSLayoutConstraint!
    @IBOutlet weak var cnstLeadingVwMainDetail: NSLayoutConstraint!
    @IBOutlet weak var cnstHeightImgVwBottomLogo: NSLayoutConstraint! // 280
    @IBOutlet weak var cnstTopLogo: NSLayoutConstraint!
    @IBOutlet weak var imgVwBottomLogo: UIImageView!
    
    var objLoginVM = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        txtFldEmail.text = "infothreeg@gmail.com" // "howard.benioff@mindfulnessmiddle.org" //
//        txtFldPassword.text = "12345678" // "12345678" //
        txtFldEmail.textContentType = .username
        txtFldEmail.keyboardType = .emailAddress
        txtFldPassword.textContentType = .password
        btnLogin.setTitleFont("Login", fontName: AppFontName.mulishExtraBold, size: isIpadView ? 27 : 19)
        btnForgotPassword.setTitleFont("Forgot Password?", fontName: AppFontName.mulishMedium, size: isIpadView ? 25 : 17)
        let formatStr = NSMutableAttributedString()
        formatStr.attributedString(str1: "\(AppAlerts.titleValue.welcomeBack)", color: AppColor.appBlueColor, font: UIFont(name: AppFontName.mulishMedium, size:  isIpadView ? 27 : 19)!, lineHeight: 1.3, align: TextAlign.center)
        lblDescription.attributedText = formatStr
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            debugPrint("Landscape")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = (self.view.frame.size.width / 2)
                cnstTrailingVwMainDetail.constant = 50
                cnstHeightImgVwBottomLogo.constant = 20
                imgVwBottomLogo.isHidden = true
                imgVwLandscaple.isHidden = false
            }
        } else {
            debugPrint("Portrait")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = 120
                cnstTrailingVwMainDetail.constant = 120
                cnstHeightImgVwBottomLogo.constant = 280
            }
            imgVwLandscaple.isHidden = true
            imgVwBottomLogo.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UIDevice.current.orientation.isLandscape {
            debugPrint("Landscape")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = (self.view.frame.size.height / 2) - 20
                cnstTrailingVwMainDetail.constant = 50
                cnstHeightImgVwBottomLogo.constant = 20
                imgVwLandscaple.isHidden = false
                imgVwBottomLogo.isHidden = true
            }
        } else {
            debugPrint("Portrait")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = 120
                cnstTrailingVwMainDetail.constant = 120
                cnstHeightImgVwBottomLogo.constant = 280
            }
            imgVwLandscaple.isHidden = true
            imgVwBottomLogo.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            Zendesk.initialize(withChannelKey: ZendeskInfo.channelKey,messagingFactory: DefaultMessagingFactory()) { result in
                if case let .failure(error) = result {
                    debugPrint("Messaging did not initialize.\nError: \(error.localizedDescription)")
                } else {
                    debugPrint("Initialize Successfully")
                }
            }
        }
    }
    
    @IBAction func actionBtnLogin(_ sender: Any) {
        self.view.endEditing(true)
        let request = Login.Request(email: txtFldEmail.text ?? "", password: txtFldPassword.text ?? "")
        if isValidData(request) {
            self.startLoaderMethod()
            objLoginVM.hitSignInApiMethod(request, viewCont: self) { (isSuccess,messageStr) in
                if isSuccess {
                    isFirstTimeLaunch = true
                    CustomerIO.shared.identify(identifier: userLoginId, body: ["id": userLoginId])
                    // CustomerIO.shared.deviceAttributes = ["id":deviceTokenSaved,"platform":"ios","push_enabled":"true","device_model":"\(UIDevice.modelName)"]
                    MessagingPush.shared.registerDeviceToken(deviceTokenSaved)
                    Heap.identify(userLoginId)
                    self.objLoginVM.hitUserAuthorizationApiMethod(self) {
                        let userProperties = [
                            "Name":self.objLoginVM.objUserDetailModel.accountName,
                            "Email":self.objLoginVM.objUserDetailModel.email,
                            "AccountID":self.objLoginVM.objUserDetailModel.accountId,
                            "UserID":self.objLoginVM.objUserDetailModel.userId,
                            "AccountName":self.objLoginVM.objUserDetailModel.accountName,
                            "ParentAccountName":self.objLoginVM.objUserDetailModel.accountName
                        ]
                        Heap.addUserProperties(userProperties)
                        Zendesk.instance?.loginUser(with: self.objLoginVM.jwtToken) { result in
                            switch result {
                            case .success(let user):
                                debugPrint("User:- ",user.id)
                            case .failure(let error):
                                debugPrint("Zendesk Error:- ",error.localizedDescription)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                isComeFromLogin = true
                                RootControllerMethod.shared.rootWithoutDrawer(ContollerName.homeVC, storyBoardType: .login)
                            }
                        }
                    }
                } else {
                    self.vwLoaderInfo.isHidden = true
                    self.imgVwLoader.image = nil
                    self.cnstBottomVwYellow.constant = 0
                    self.displayAlertMessage(messageStr)
                }
            }
        }
    }
    
    @IBAction func actionBtnForgotPassword(_ sender: Any) {
        self.view.endEditing(true)
        let controllerObj = getStoryBorad(.login).instantiateViewController(withIdentifier: ContollerName.forgotPasswordVC) as! ForgotPasswordVC
        self.navigationController?.pushViewController(controllerObj, animated: true)
    }
    
}
