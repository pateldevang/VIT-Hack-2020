//
//  ForgotPasswordVC.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    
    @IBOutlet var emailTextField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func proceedClicked(_ sender: UIButton) {
        FirebaseAuth.forgetPassword(email: emailTextField.text!) { (result) in
            switch result{
            case "Success":
                self.authAlert(titlepass: "Success 😄", message: "check Your email")
            default:
                self.authAlert(titlepass: "uh oh! 😓", message: result)
            }
        }
    }
}
