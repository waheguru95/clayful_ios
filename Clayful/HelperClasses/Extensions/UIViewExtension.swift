//
//  UIViewExtension.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit
import AVFoundation

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            if UIDevice.current.userInterfaceIdiom == .phone {
                layer.cornerRadius = newValue
                layer.masksToBounds = newValue > 0
            }
        }
    }
    
    @IBInspectable var cornerRadiusiPad: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            if UIDevice.current.userInterfaceIdiom == .pad {
                layer.cornerRadius = newValue
                layer.masksToBounds = newValue > 0
            }
        }
    }
    
    @IBInspectable var borderColor:UIColor? {
        get {
            return UIColor(cgColor:layer.borderColor!)
        } set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth:Float {
        get {
            return Float(layer.borderWidth)
        }
        set {
            layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = newValue
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.shadowColor!)
            return color
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
}

extension NSMutableAttributedString {
    
    @discardableResult func normal(_ text: String,font: UIFont) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: font]
        let normal = NSAttributedString(string:text, attributes: attrs)
        append(normal)
        return self
    }
}

extension NSMutableAttributedString {
    
    //MARK:- Attributed String
    @discardableResult func attributedString(str1:String,color: UIColor,font:UIFont,lineHeight:CGFloat,align:String) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = align == TextAlign.center ? .center : .left
        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: color, NSAttributedString.Key.font: font,.paragraphStyle : paragraphStyle]
        let firstString = NSMutableAttributedString(string: str1, attributes: firstAttributes)
        append(firstString)
        return self
    }
}
