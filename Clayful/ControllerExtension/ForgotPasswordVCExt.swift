//
//  ForgotPasswordVCExt.swift
//  Clayful
//
//  Created by TajinderMohal on 14/05/22.
//

import UIKit

extension ForgotPasswordVC: UITextFieldDelegate {
    
    //MARK:- Text Field Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Text Field Delegate Method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            return false
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        lblEmailError.isHidden = true
        lblEmailError.text = "Email cannot be empty"
        cnstHeightLblEmailError.constant = 0
        vwEmail.layer.borderColor = AppColor.appBlueColor.cgColor
        DispatchQueue.main.async {
            let screenSize: CGRect = UIScreen.main.bounds
            let bottomOffset = CGPoint(x: 0, y: screenSize.height <= 667.0 ? 100 : 80)
            self.scrollVwContent.setContentOffset(bottomOffset, animated: true)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if vwEmail.layer.borderColor != UIColor.red.cgColor {
            vwEmail.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
        }
    }
    
}
extension ForgotPasswordVC {
    
    //MARK:- Check Data is Valid
    func isValidData(_ request: ForgotPassword.Request) -> Bool {
        if request.email!.isBlank {
            lblEmailError.isHidden = false
            lblEmailError.text = "Email cannot be empty"
            cnstHeightLblEmailError.constant = 26
            vwEmail.layer.borderColor = UIColor.red.cgColor
            vwEmail.shake()
            return false
        } else if !CommonMethod.shared.isValidEmail(request.email!) {
            lblEmailError.isHidden = false
            lblEmailError.text = "Entered email address is not valid"
            cnstHeightLblEmailError.constant = 26
            vwEmail.layer.borderColor = UIColor.red.cgColor
            vwEmail.shake()
            return false
        } else {
            lblEmailError.isHidden = true
            lblEmailError.text = "Email cannot be empty"
            cnstHeightLblEmailError.constant = 0
            vwEmail.layer.borderColor =  AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
        }
        return true
    }
}
