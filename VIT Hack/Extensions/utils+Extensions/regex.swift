//
//  regex.swift
//  VIT Hack
//
//  Created by Devang Patel on 15/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation

extension String {
    var isValidPhone: Bool {
        // Indian Numbering system 6000000000 to 9999999999
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    var isRegNo: Bool {
        do {
            // format of YZ(Branch)XXXX where Y - [1,2], Z - [0-9] & X - [A-Z]
            //1[0-9]BCE0811 VALID
            //20BCE0811 VALID
            //21BCE0811 NOT VALID
            let regex = try NSRegularExpression(pattern: "^[1-2]{1}[0-9]{1}[A-Z]{3}[0-9]{4}$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isRoomNo: Bool {
        do {
            // format of XYYYY where Y - [0,9] & X - [A-T]
            // [A-T][0-9][0-9][0-9] VALID
            // [A-T][0-9][0-9][0-9][0-9] VALID
            //[A-T][0-9] NOT VALID
            //[A-T][0-9][0-9] NOT VALID
            var length: Int { return self.count }
            if (length > 3 && length < 6) {
            }
            else {
                return false
            }
            let regex = try NSRegularExpression(pattern: "^[A-T][0-9][0-9][0-9]*[0-9]$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
}


