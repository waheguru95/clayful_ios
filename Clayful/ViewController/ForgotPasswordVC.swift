//
//  ForgotPasswordVC.swift
//  Clayful
//
//  Created by TajinderMohal on 14/05/22.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var btnResetEmail: UIButton!
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var cnstHeightLblEmailError: NSLayoutConstraint! //30
    @IBOutlet weak var scrollVwContent: UIScrollView!
    @IBOutlet weak var cnstTrailingVwMainDetail: NSLayoutConstraint!
    @IBOutlet weak var cnstLeadingVwMainDetail: NSLayoutConstraint!
    
    var objForgotPasswordVM = ForgotPasswordVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //txtFldEmail.text = "Aditi.3ginfo@gmail.com"
        btnResetEmail.setTitleFont("Send instructions", fontName: AppFontName.mulishExtraBold, size: isIpadView ? 27 : 19)
        let formatStr = NSMutableAttributedString()
        formatStr.attributedString(str1: AppAlerts.titleValue.forgotPasswordDescript, color: AppColor.appBlueColor, font: UIFont(name: AppFontName.mulishMedium, size: isIpadView ? 27 : 19)!, lineHeight: 1.3, align: TextAlign.left)
        lblDescription.attributedText = formatStr
        txtFldEmail.textContentType = .username
        txtFldEmail.keyboardType = .emailAddress
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
    
    @IBAction func actionBtnSubmit(_ sender: Any) {
        self.view.endEditing(true)
        vwEmail.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
        let request = ForgotPassword.Request(email: txtFldEmail.text ?? "")
        if isValidData(request) {
            objForgotPasswordVM.hitForgotPasswordApiMethod(request, viewCont: self) {
                let controllerObj = getStoryBorad(.login).instantiateViewController(withIdentifier: ContollerName.resetPasswordVC) as! ResetPasswordVC
                controllerObj.objResetPasswordVM.emailStr = self.txtFldEmail.text ?? ""
                self.navigationController?.pushViewController(controllerObj, animated: true)
            }
        }
    }
    
    @IBAction func actionBtnBack(_ sender: Any) {
        self.popViewController(true)
    }
    
    @IBAction func actionBtnResetPassword(_ sender: Any) {
        self.pushToNextController(ContollerName.resetPasswordVC, storyBoardName: .login, isAnimation: true)
    }
    
}
