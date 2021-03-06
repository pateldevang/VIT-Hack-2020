//
//  AboutUsData.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 22/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

struct AboutUsData {
    let name : String
    let role : String
    let image : String
    let socialHandles : [socialMedia]
    var socailUrls : [String]
}

enum socialMedia : String {
    case github
    case LinkedIn
    case instagram
    case mail
    case twitter
    case dribble
}


