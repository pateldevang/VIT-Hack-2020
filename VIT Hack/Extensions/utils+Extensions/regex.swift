//
//  regex.swift
//  VIT Hack
//
//  Created by Devang Patel on 15/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation

extension String {
    
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

}


