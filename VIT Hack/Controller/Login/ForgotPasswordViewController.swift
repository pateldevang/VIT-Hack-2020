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
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.setUnderLine()
        sendButton.bottomShadow()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func SendLink(_ sender: UIButton) {
        if validate(){
            resetPassword()
        }
    }
    
    func resetPassword(){
        FirebaseAuth.forgetPassword(email: emailTextField.text!) { (response) in
            if response == "Success"{
                self.emailSuccessAlert()
            } else {
                self.authAlert(message: response)
            }
        }
    }
    
    func validate()->Bool{
        if emailTextField.text?.isEmpty ?? true {
            authAlert(message: "Please enter your Email Address.")
            return false
        }
        
        if !(emailTextField.text?.isEmail ?? false){
            authAlert(message: "Please enter a valid Email Address.")
            return false
        }
        return true
    }
    
}

extension ForgotPasswordViewController {
    //MARK: - ALERT fucntion for success forget password
    func emailSuccessAlert() {
        UIDevice.validVibrate()
        let alert = UIAlertController(title: "yay 😄", message: "Please check your mail" , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Mail", style: .cancel) { (_) -> Void in
            let settingsUrl =  URL(string: "message://")
            if let url = settingsUrl {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        })
        alert.addAction(UIAlertAction(title: "dissmiss", style: .default){ (a) in
            self.navigationController?.popViewController(animated: true)
        })
            present(alert, animated: true, completion: nil)
    }
}
