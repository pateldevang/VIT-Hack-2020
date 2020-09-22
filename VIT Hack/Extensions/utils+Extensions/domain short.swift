//
//  domain short.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 22/09/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation

extension String {
    var domainShortValue : String {
        let domains = ["fintech":"FT","healthcare":"HC","edtech":"ET","mobility":"MB","cybersec":"SC","crisis response":"CR"]
        return domains[self.lowercased()] ?? ""
    }
}
