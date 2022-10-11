//
//  ResetPasswordVCExt.swift
//  Clayful
//
//  Created by netset on 20/05/22.
//

import UIKit

extension ResetPasswordVC: UITextFieldDelegate {
    
    //MARK:- Text Field Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFldCode {
            txtFldCode.goToNextTextFeild(nextTextFeild: txtFldNewPassword)
        } else if textField == txtFldNewPassword {
            txtFldNewPassword.goToNextTextFeild(nextTextFeild: txtFldConfirmPassword)
        } else {
            txtFldConfirmPassword.resignFirstResponder()
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
        if textField == txtFldCode {
            vwCode.layer.borderColor = AppColor.appBlueColor.cgColor
            lblCodeError.isHidden = true
            lblCodeError.text = AppAlerts.titleValue.codeEmpty
            cnstHeightLblCode.constant = 0
            if vwNewPassword.layer.borderColor != UIColor.red.cgColor {
                vwNewPassword.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
            }
            if vwConfirmPassword.layer.borderColor != UIColor.red.cgColor {
                vwConfirmPassword.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
            }
        } else if textField == txtFldNewPassword {
            vwNewPassword.layer.borderColor = AppColor.appBlueColor.cgColor
            lblPasswordError.isHidden = true
            lblPasswordError.text = AppAlerts.titleValue.passwordMinimum8Limit
            cnstHeightLblPassword.constant = 0
            if vwCode.layer.borderColor != UIColor.red.cgColor {
                vwCode.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
            }
            if vwConfirmPassword.layer.borderColor != UIColor.red.cgColor {
                vwConfirmPassword.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
            }
        } else if textField == txtFldConfirmPassword {
            vwConfirmPassword.layer.borderColor = AppColor.appBlueColor.cgColor
            lblConfirmPasswordError.isHidden = true
            lblConfirmPasswordError.text = AppAlerts.titleValue.confirmPasswordEmpty
            cnstHeightLblConfirmPassword.constant = 0
            if vwCode.layer.borderColor != UIColor.red.cgColor {
                vwCode.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
            }
            if vwNewPassword.layer.borderColor != UIColor.red.cgColor {
                vwNewPassword.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let screenSize: CGRect = UIScreen.main.bounds
                let bottomOffset = CGPoint(x: 0, y: screenSize.height <= 667.0 ? 270 : 200)
                self.scrollVwContent.setContentOffset(bottomOffset, animated: true)
            }
        }
        return true
    }
    
    @objc func keyboardWillDisappear() {
        if vwCode.layer.borderColor != UIColor.red.cgColor {
            vwCode.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
        }
        if vwNewPassword.layer.borderColor != UIColor.red.cgColor {
            vwNewPassword.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
        }
        if vwConfirmPassword.layer.borderColor != UIColor.red.cgColor {
            vwConfirmPassword.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
        }
    }
    
}
extension ResetPasswordVC {
    
    //MARK:- Check Data is Valid
    func isValidData(_ request: ResetPassword.Request) -> Bool {
        if request.codeStr!.isBlank && request.newPassword!.isBlank && request.confirmPassword!.isBlank {
            lblCodeError.isHidden = false
            lblPasswordError.isHidden = false
            lblConfirmPasswordError.isHidden = false
            lblCodeError.text = AppAlerts.titleValue.codeEmpty
            lblPasswordError.text = AppAlerts.titleValue.newPasswordEmpty
            lblConfirmPasswordError.text = AppAlerts.titleValue.confirmPasswordEmpty
            cnstHeightLblCode.constant = 30
            cnstHeightLblPassword.constant = 30
            cnstHeightLblConfirmPassword.constant = 30
            vwCode.layer.borderColor = UIColor.red.cgColor
            vwNewPassword.layer.borderColor = UIColor.red.cgColor
            vwConfirmPassword.layer.borderColor = UIColor.red.cgColor
            vwCode.shake()
            vwNewPassword.shake()
            vwConfirmPassword.shake()
            return false
        } else if request.codeStr!.isBlank {
            lblCodeError.isHidden = false
            lblCodeError.text = AppAlerts.titleValue.codeEmpty
            cnstHeightLblCode.constant = 30
            vwCode.layer.borderColor = UIColor.red.cgColor
            vwCode.shake()
            if request.newPassword!.isBlank {
                lblPasswordError.isHidden = false
                lblPasswordError.text = AppAlerts.titleValue.newPasswordEmpty
                cnstHeightLblPassword.constant = 30
                vwNewPassword.layer.borderColor = UIColor.red.cgColor
                vwNewPassword.shake()
            } else if (request.newPassword?.count ?? 0) < 8 {
                lblPasswordError.isHidden = false
                lblPasswordError.text = AppAlerts.titleValue.passwordMinimum8Limit
                cnstHeightLblPassword.constant = 30
                vwNewPassword.layer.borderColor = UIColor.red.cgColor
                vwNewPassword.shake()
            }
            if request.confirmPassword!.isBlank {
                lblConfirmPasswordError.isHidden = false
                lblConfirmPasswordError.text = AppAlerts.titleValue.confirmPasswordEmpty
                cnstHeightLblConfirmPassword.constant = 30
                vwConfirmPassword.layer.borderColor = UIColor.red.cgColor
                vwConfirmPassword.shake()
            } else {
                if !(request.newPassword!.isBlank) {
                    if (request.newPassword! != request.confirmPassword!) {
                        lblConfirmPasswordError.isHidden = false
                        lblConfirmPasswordError.text = AppAlerts.titleValue.confirmNotMatch
                        cnstHeightLblConfirmPassword.constant = 30
                        vwConfirmPassword.layer.borderColor = UIColor.red.cgColor
                        vwConfirmPassword.shake()
                    }
                } else if !(request.confirmPassword!.isBlank) {
                    vwConfirmPassword.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
                    lblConfirmPasswordError.isHidden = true
                    lblConfirmPasswordError.text = AppAlerts.titleValue.confirmPasswordEmpty
                    cnstHeightLblConfirmPassword.constant = 0
                }
            }
            return false
        } else if request.newPassword!.isBlank {
            lblPasswordError.isHidden = false
            lblPasswordError.text = AppAlerts.titleValue.newPasswordEmpty
            cnstHeightLblPassword.constant = 30
            vwNewPassword.layer.borderColor = UIColor.red.cgColor
            vwNewPassword.shake()
            if request.codeStr!.isBlank {
                lblCodeError.isHidden = false
                lblCodeError.text = AppAlerts.titleValue.codeEmpty
                cnstHeightLblCode.constant = 30
                vwCode.layer.borderColor = UIColor.red.cgColor
                vwCode.shake()
            }
            if request.confirmPassword!.isBlank {
                lblConfirmPasswordError.isHidden = false
                lblConfirmPasswordError.text = AppAlerts.titleValue.confirmPasswordEmpty
                cnstHeightLblConfirmPassword.constant = 30
                vwConfirmPassword.layer.borderColor = UIColor.red.cgColor
                vwConfirmPassword.shake()
            } else {
                vwConfirmPassword.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
                lblConfirmPasswordError.isHidden = true
                lblConfirmPasswordError.text = AppAlerts.titleValue.confirmPasswordEmpty
                cnstHeightLblConfirmPassword.constant = 0
            }
            return false
        } else if (request.newPassword?.count ?? 0) < 8 {
            lblPasswordError.isHidden = false
            lblPasswordError.text = AppAlerts.titleValue.passwordMinimum8Limit
            cnstHeightLblPassword.constant = 30
            vwNewPassword.layer.borderColor = UIColor.red.cgColor
            vwNewPassword.shake()
            if request.codeStr!.isBlank {
                lblCodeError.isHidden = false
                lblCodeError.text = AppAlerts.titleValue.codeEmpty
                cnstHeightLblCode.constant = 30
                vwCode.layer.borderColor = UIColor.red.cgColor
                vwCode.shake()
            }
            if request.confirmPassword!.isBlank {
                lblConfirmPasswordError.isHidden = false
                lblConfirmPasswordError.text = AppAlerts.titleValue.confirmPasswordEmpty
                cnstHeightLblConfirmPassword.constant = 30
                vwConfirmPassword.layer.borderColor = UIColor.red.cgColor
                vwConfirmPassword.shake()
            } else if (request.newPassword! != request.confirmPassword!) {
                lblConfirmPasswordError.isHidden = false
                lblConfirmPasswordError.text = AppAlerts.titleValue.confirmNotMatch
                cnstHeightLblConfirmPassword.constant = 30
                vwConfirmPassword.layer.borderColor = UIColor.red.cgColor
                vwConfirmPassword.shake()
            }
            return false
        } else if request.confirmPassword!.isBlank {
            lblConfirmPasswordError.isHidden = false
            lblConfirmPasswordError.text = AppAlerts.titleValue.confirmPasswordEmpty
            cnstHeightLblConfirmPassword.constant = 30
            vwConfirmPassword.layer.borderColor = UIColor.red.cgColor
            vwConfirmPassword.shake()
            if request.codeStr!.isBlank {
                lblCodeError.isHidden = false
                lblCodeError.text = AppAlerts.titleValue.codeEmpty
                cnstHeightLblCode.constant = 30
                vwCode.layer.borderColor = UIColor.red.cgColor
                vwCode.shake()
            }
            if request.newPassword!.isBlank {
                lblPasswordError.isHidden = false
                lblPasswordError.text = AppAlerts.titleValue.newPasswordEmpty
                cnstHeightLblPassword.constant = 30
                vwNewPassword.layer.borderColor = UIColor.red.cgColor
                vwNewPassword.shake()
            } else if (request.newPassword?.count ?? 0) < 8 {
                lblPasswordError.isHidden = false
                lblPasswordError.text = AppAlerts.titleValue.passwordMinimum8Limit
                cnstHeightLblPassword.constant = 30
                vwNewPassword.layer.borderColor = UIColor.red.cgColor
                vwNewPassword.shake()
            }
            return false
        } else if (request.newPassword! != request.confirmPassword!) {
            lblConfirmPasswordError.isHidden = false
            lblConfirmPasswordError.text = AppAlerts.titleValue.confirmNotMatch
            cnstHeightLblConfirmPassword.constant = 30
            vwConfirmPassword.layer.borderColor = UIColor.red.cgColor
            vwConfirmPassword.shake()
            if request.codeStr!.isBlank {
                lblCodeError.isHidden = false
                lblCodeError.text = AppAlerts.titleValue.codeEmpty
                cnstHeightLblCode.constant = 30
                vwCode.layer.borderColor = UIColor.red.cgColor
                vwCode.shake()
            }
            if request.newPassword!.isBlank {
                lblPasswordError.isHidden = false
                lblPasswordError.text = AppAlerts.titleValue.newPasswordEmpty
                cnstHeightLblPassword.constant = 30
                vwNewPassword.layer.borderColor = UIColor.red.cgColor
                vwNewPassword.shake()
            } else if (request.newPassword?.count ?? 0) < 8 {
                lblPasswordError.isHidden = false
                lblPasswordError.text = AppAlerts.titleValue.passwordMinimum8Limit
                cnstHeightLblPassword.constant = 30
                vwNewPassword.layer.borderColor = UIColor.red.cgColor
                vwNewPassword.shake()
            }
            return false
        } else {
            lblCodeError.isHidden = true
            lblPasswordError.isHidden = true
            lblConfirmPasswordError.isHidden = true
            lblCodeError.text = AppAlerts.titleValue.codeEmpty
            lblPasswordError.text = AppAlerts.titleValue.newPasswordEmpty
            lblConfirmPasswordError.text = AppAlerts.titleValue.confirmPasswordEmpty
            cnstHeightLblCode.constant = 0
            cnstHeightLblPassword.constant = 0
            cnstHeightLblConfirmPassword.constant = 0
            vwCode.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
            vwNewPassword.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
            vwConfirmPassword.layer.borderColor = AppColor.appBlueColor.withAlphaComponent(0.2).cgColor
        }
        return true
    }
}
extension ResetPasswordVC {
    
    //MARK:- Configure Custom PopUp Method
    func configureCustomPopUp(_ titleDes: String,openIn:UIButton) {
        objResetPasswordVM.popTip = Popover(options: objResetPasswordVM.popoverOptions)
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 80))
        let label = UILabel(frame: CGRect(x: 12, y: 8, width: 250 - 16, height: 80 - 16))
        label.numberOfLines = 0
        label.text = titleDes
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: AppFontName.mulishMedium, size: 17)
        customView.addSubview(label)
        customView.backgroundColor = AppColor.appBlueColor
        objResetPasswordVM.popTip.popoverColor = AppColor.appBlueColor
        objResetPasswordVM.popTip.show(customView, fromView: openIn)
    }
}
