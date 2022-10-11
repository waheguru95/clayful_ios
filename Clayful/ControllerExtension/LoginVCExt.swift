//
//  LoginVCExt.swift
//  Clayful
//
//  Created by TajinderMohal on 13/05/22.
//

import UIKit
import IQKeyboardManagerSwift

extension LoginVC: UITextFieldDelegate {
    
    //MARK:- Text Field Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFldEmail {
            txtFldEmail.goToNextTextFeild(nextTextFeild: txtFldPassword)
        } else {
            txtFldPassword.resignFirstResponder()
        }
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
        if textField == txtFldEmail {
            vwEmail.layer.borderColor = AppColor.appBlueColor.cgColor
            cnstHeightLblEmailError.constant = 0
            lblEmailError.isHidden = true
            lblEmailError.text = "Email cannot be empty"
            if vwPassword.layer.borderColor != UIColor.red.cgColor {
                vwPassword.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
            }
        } else {
            vwPassword.layer.borderColor = AppColor.appBlueColor.cgColor
            cnstHeightLblPasswordError.constant = 0
            lblPasswordError.isHidden = true
            lblPasswordError.text = "Password cannot be empty"
            if vwEmail.layer.borderColor != UIColor.red.cgColor {
                vwEmail.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let screenSize: CGRect = UIScreen.main.bounds
                let bottomOffset = CGPoint(x: 0, y: screenSize.height <= 667.0 ? 180 : 110)
                self.scrollVwContent.setContentOffset(bottomOffset, animated: true)
            }
        }
        return true
    }
    
    @objc func keyboardWillDisappear() {
        if vwEmail.layer.borderColor != UIColor.red.cgColor {
            vwEmail.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
        }
        if vwPassword.layer.borderColor != UIColor.red.cgColor {
            vwPassword.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
        }
    }
    
}

extension LoginVC {
    
    //MARK:- Check Data is Valid
    func isValidData(_ request: Login.Request) -> Bool {
        if request.email!.isBlank && request.password!.isBlank {
            lblEmailError.isHidden = false
            lblPasswordError.isHidden = false
            lblEmailError.text = "Email cannot be empty"
            lblPasswordError.text = "Password cannot be empty"
            cnstHeightLblEmailError.constant = 30
            cnstHeightLblPasswordError.constant = 30
            vwEmail.layer.borderColor = UIColor.red.cgColor
            vwPassword.layer.borderColor = UIColor.red.cgColor
            vwEmail.shake()
            vwPassword.shake()
            return false
        } else if request.email!.isBlank {
            lblEmailError.isHidden = false
            lblEmailError.text = "Email cannot be empty"
            cnstHeightLblEmailError.constant = 30
            vwEmail.layer.borderColor = UIColor.red.cgColor
            vwEmail.shake()
            if request.password!.isBlank {
                lblPasswordError.isHidden = false
                lblPasswordError.text = "Password cannot be empty"
                cnstHeightLblPasswordError.constant = 30
                vwPassword.layer.borderColor = UIColor.red.cgColor
                vwPassword.shake()
            }
            return false
        } else if !CommonMethod.shared.isValidEmail(request.email!) {
            lblEmailError.isHidden = false
            lblEmailError.text = "Entered email address is not valid"
            cnstHeightLblEmailError.constant = 30
            vwEmail.layer.borderColor = UIColor.red.cgColor
            vwEmail.shake()
            if request.password!.isBlank {
                lblPasswordError.isHidden = false
                lblPasswordError.text = "Password cannot be empty"
                cnstHeightLblPasswordError.constant = 30
                vwPassword.layer.borderColor = UIColor.red.cgColor
                vwPassword.shake()
            }
            return false
        } else if request.password!.isBlank {
            lblPasswordError.isHidden = false
            lblPasswordError.text = "Password cannot be empty"
            cnstHeightLblPasswordError.constant = 30
            vwPassword.layer.borderColor = UIColor.red.cgColor
            vwPassword.shake()
            if request.email!.isBlank {
                lblEmailError.isHidden = false
                lblEmailError.text = "Email cannot be empty"
                cnstHeightLblEmailError.constant = 30
                vwEmail.layer.borderColor = UIColor.red.cgColor
                vwEmail.shake()
            }
            return false
        } else {
            lblEmailError.isHidden = true
            lblPasswordError.isHidden = true
            lblEmailError.text = "Email cannot be empty"
            lblPasswordError.text = "Password cannot be empty"
            cnstHeightLblEmailError.constant = 0
            cnstHeightLblPasswordError.constant = 0
            vwEmail.layer.borderColor =  AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
            vwPassword.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
        }
        return true
    }
    
    func startLoaderMethod() {
        cnstBottomVwYellow.constant = 0
        vwLoaderInfo.isHidden = false
        imgVwLoader.image = UIImage.gifImageWithName(name: "safe-gif")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.cnstBottomVwYellow.constant = 160
                self.view.layoutIfNeeded()
            }, completion: {
                (value: Bool) in
            })
        }
    }
}
