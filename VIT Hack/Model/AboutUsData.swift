//
//  AboutUsData.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 22/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation

struct AboutUsData {
    let name : String
    let role : String
    let image : String
    let socialHandles : [socialMedia]
}

enum socialMedia : String {
    case github
    case LinkedIn
    case instagram
    case mail
    case twitter
}
