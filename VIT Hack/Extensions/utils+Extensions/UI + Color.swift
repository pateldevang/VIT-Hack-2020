//
//  UI + Color.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 19/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
    self.init(red : r/255, green : g/255, blue: b/255, alpha: 1)
    }
}
