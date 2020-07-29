//
//  Navigation.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 29/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class Navigation: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
@IBAction func unwindToHome(segue:UIStoryboardSegue) {
    self.popToRootViewController(animated: true)
    }

}
