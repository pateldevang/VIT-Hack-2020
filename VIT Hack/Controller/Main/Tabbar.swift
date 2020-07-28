//
//  Tabbar.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 28/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

//MARK: Hides Navigationbar of UITabbarController

class Tabbar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
}

//END
