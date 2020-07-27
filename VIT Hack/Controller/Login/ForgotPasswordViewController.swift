//
//  ForgotPasswordViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.setUnderLine()
    }
    
    @IBAction func SendLink(_ sender: UIButton) {
        if validate(){
            resetPassword()
        }
    }
    
    func resetPassword(){
        FirebaseAuth.forgetPassword(email: emailTextField.text!) { (response) in
            if response == "Success"{
                self.dismissAlert(titlepass: "yay 😄", message: "Reset link sent to email.")
            } else {
                self.authAlert(titlepass: "Uh oh 😕", message: response)
            }
        }
    }
    
    func validate()->Bool{
        if emailTextField.text?.isEmpty ?? true {
            authAlert(titlepass: "Empty Field", message: "Please enter your Email Address.")
            return false
        }
        
        if !(emailTextField.text?.isEmail ?? false){
            authAlert(titlepass: "Invalid Field", message: "Please enter a valid Email Address.")
            return false
        }
        return true
    }
    
}
