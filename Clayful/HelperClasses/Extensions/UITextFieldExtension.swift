//
//  UITextFieldExtension.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit

//MARK:- IBInspectable Extension
private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
  
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        let selection = selectedTextRange
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        selectedTextRange = selection
    }
}

//MARK:- Extension
extension UITextField {
    
    var isBlank : Bool {
        return (self.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)!
    }
    
    var trimmedValue : String {
        return (self.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
    }
    
    func setPlaceHolderColor(txtString: String,color: UIColor){
        self.attributedPlaceholder = NSAttributedString(string: txtString, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    
    func goToNextTextFeild(nextTextFeild:UITextField) {
        self.resignFirstResponder()
        nextTextFeild.becomeFirstResponder()
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setLeftPaddingImage(_ leftImage:UIImage,color:UIColor? = nil) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: (self.frame.size.height - self.frame.size.height/4)/2 + 8.0, height: self.frame.size.height/2))
        let paddingView = UIImageView(frame: CGRect(x: 8.0, y: 0.0, width: (self.frame.size.height - self.frame.size.height/4)/2, height: (self.frame.size.height)/2))
        paddingView.image = leftImage
        paddingView.clipsToBounds = true
        paddingView.contentMode = .scaleAspectFit
        
        leftView.addSubview(paddingView)
        self.leftView = leftView
        self.leftViewMode = .always
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : color != nil ? color! : .white])
    }
    
}
extension UIView {
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
        animation.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y)
        layer.add(animation, forKey: "position")
    }
}
