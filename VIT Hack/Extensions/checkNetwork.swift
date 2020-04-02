//
//  checkNetwork.swift
//  VIT Hack
//
//  Created by Devang Patel on 02/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    internal func checkNewtork(ifError: String) {
        checkConnection { (status, statusCode) in
            if statusCode == 404{
                print("No connection!!")
                // Vibrates on errors
                UIDevice.invalidVibrate()
                self.networkErrorAlert(titlepass: ifError)
            }else{
                print("connection existing")
            }
        }
    }
}
