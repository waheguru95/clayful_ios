//
//  ResetPasswordVC.swift
//  Clayful
//
//  Created by netset on 20/05/22.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var btnResetPassword: UIButton!
    @IBOutlet weak var txtFldConfirmPassword: UITextField!
    @IBOutlet weak var txtFldNewPassword: UITextField!
    @IBOutlet weak var txtFldCode: UITextField!
    @IBOutlet weak var vwConfirmPassword: UIView!
    @IBOutlet weak var vwNewPassword: UIView!
    @IBOutlet weak var vwCode: UIView!
    @IBOutlet weak var cnstHeightLblConfirmPassword: NSLayoutConstraint! // 30
    @IBOutlet weak var cnstHeightLblPassword: NSLayoutConstraint! //30
    @IBOutlet weak var cnstHeightLblCode: NSLayoutConstraint! //30
    @IBOutlet weak var lblConfirmPasswordError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    @IBOutlet weak var lblCodeError: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var scrollVwContent: UIScrollView!
    @IBOutlet weak var cnstBottomMainVw: NSLayoutConstraint!
    @IBOutlet weak var cnstTrailingVwMainDetail: NSLayoutConstraint!
    @IBOutlet weak var cnstLeadingVwMainDetail: NSLayoutConstraint!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var lblNewPassword: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblSendNewCode: UILabel!
    
    var objResetPasswordVM = ResetPasswordVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        if UIDevice.current.orientation.isLandscape {
            debugPrint("Landscape")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = 280
                cnstTrailingVwMainDetail.constant = 280
            }
        } else {
            debugPrint("Portrait")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = 120
                cnstTrailingVwMainDetail.constant = 120
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
            }
        } else {
            debugPrint("Portrait")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = 120
                cnstTrailingVwMainDetail.constant = 120
            }
        }
    }
    
    @IBAction func actionBtnBack(_ sender: Any) {
        self.popViewController(true)
    }
    
    @IBAction func actionBtnNewResendCode(_ sender: Any) {
        self.popViewController(true)
    }
    
    @IBAction func actionBtnResetPassword(_ sender: Any) {
        self.view.endEditing(true)
        let request = ResetPassword.Request(codeStr: txtFldCode.text ?? "", newPassword: txtFldNewPassword.text ?? "", confirmPassword: txtFldConfirmPassword.text ?? "")
        if isValidData(request) {
            objResetPasswordVM.hitResetPasswordApiMethod(request, viewCont: self) {
                self.pushToNextController(ContollerName.passwordChangedSuccessVC, storyBoardName: .login, isAnimation: true)
            }
        }
    }
    
    @IBAction func actionBtnMoreInfo(_ sender: UIButton) {
        let messageStr = "Password must contain at least 8 letters and numbers."
        configureCustomPopUp(messageStr, openIn: sender)
    }
    
}

extension ResetPasswordVC {
    
    func prepareUI() {
        txtFldNewPassword.textContentType = .newPassword
        txtFldConfirmPassword.textContentType = .newPassword
        btnResetPassword.setTitleFont("Reset Password", fontName: AppFontName.mulishExtraBold, size: isIpadView ? 27 : 19)
        let formatStr = NSMutableAttributedString()
        formatStr.attributedString(str1: AppAlerts.titleValue.resetDescript, color: AppColor.appBlueColor, font: UIFont(name: AppFontName.mulishMedium, size: isIpadView ? 27 : 19)!, lineHeight: 1.3, align: TextAlign.left)
        lblDescription.attributedText = formatStr
        lblCode.font = UIFont(name: AppFontName.mulishMedium, size: isIpadView ? 27 : 19)
        lblNewPassword.font = UIFont(name: AppFontName.mulishMedium, size: isIpadView ? 27 : 19)
        lblConfirmPassword.font = UIFont(name: AppFontName.mulishMedium, size: isIpadView ? 27 : 19)
        lblSendNewCode.font = UIFont(name: AppFontName.mulishMedium, size: isIpadView ? 26 : 17)
    }
}
