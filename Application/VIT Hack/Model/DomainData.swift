//
//  DomainData.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 29/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

struct DomainData: Codable {
    var abbreviation : String?
    var domain : String?
    var description : String?
    var icon : String?
    var colour : String?
    var problemStatements : [String]?
    var finalStatements : [String]?
    
    var finalData : [psModel] {
        if let psStatememnts = finalStatements{
            let data = psStatememnts.map { problem -> psModel in
                let ps = problem.split(separator: "~", maxSplits: 1, omittingEmptySubsequences: true)
                return psModel(text: String(ps.first ?? ""), url: String(ps.last ?? ""))
            }
            return data
        } else {
            return []
        }
    }
}

struct psModel {
    let text : String?
    let url : String?
}
