//
//  StringExtension.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit

extension String {
    
    var isBlank : Bool {
        return (self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    var isValidName: Bool {
        let RegEx = "^[a-zA-Z ]*$"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: self)
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isNumeric : Bool {
        return NumberFormatter().number(from: self) != nil
    }
    
    var isNumericOfPrice: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ",", "."]
        return Set(self).isSubset(of: nums)
    }
    
    func findMentionText() -> [String] {
        var arr_hasStrings:[String] = []
        let regex = try? NSRegularExpression(pattern: "(#[a-zA-Z0-9_\\p{Arabic}\\p{N}]*)", options: [])
        if let matches = regex?.matches(in: self, options:[], range:NSMakeRange(0, self.count)) {
            for match in matches {
                arr_hasStrings.append(NSString(string: self).substring(with: NSRange(location:match.range.location, length: match.range.length )))
            }
        }
        return arr_hasStrings
    }
    
    
}

extension NSObject {
    
    func getStringValue(_ value:Any) -> String {
        var strValue = String()
        if let getVal = value as? String {
            strValue = getVal
        } else if let getVal = value as? Int {
            strValue = String(getVal)
        } else if let getVal = value as? Double {
            strValue = String(getVal)
        }
        return strValue
    }
    
    func getIntegerValue(_ value:Any) -> Int {
        var integerValue = Int()
        if let getVal = value as? String {
            if getVal.isNumeric && getVal != "" {
                integerValue = Int(getVal) ?? 0
            }
        } else if let getVal = value as? Int {
            integerValue = getVal
        } else if let getVal = value as? Double {
            integerValue = Int(getVal)
        }
        return integerValue
    }
    
    func getDoubleValue(_ value:Any) -> Double {
        var doubleValue = Double()
        if let getVal = value as? String {
            if getVal.isNumericOfPrice && getVal != "" {
                doubleValue = Double(getVal) ?? 0
            }
        } else if let getVal = value as? Int {
            doubleValue = Double(getVal)
        } else if let getVal = value as? Double {
            doubleValue = getVal
        }
        return doubleValue
    }
}
