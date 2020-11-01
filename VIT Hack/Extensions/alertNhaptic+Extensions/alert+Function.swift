//
//  alert+Function.swift
//  VIT Hack
//
//  Created by Devang Patel on 02/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    //MARK: - ALERT function for Authentication
    internal func authAlert(message: String) {
        // Vibrates on errors
        UIDevice.invalidVibrate()
        let alert = UIAlertController(title: "Uh oh 🙁", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert,animated: true,completion: nil)
    }
}

