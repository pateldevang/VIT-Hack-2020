//
//  SignupViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.setUnderLine()
        passwordTextField.setUnderLine()
        continueButton.bottomShadow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showProgress()
    }
    
    func showProgress(){
        let progress = Progressbar(for: progressView, duration: 2, startValue: 0.0, endValue: 0.33)
        self.progressView.layer.insertSublayer(progress, above: self.progressView.layer)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if validate(){
        //TODO add indicator
        FirebaseAuth.emailSignIn(email: emailTextField.text!, pass: passwordTextField.text!, completion: handleSignin(authStatus:))
        }
    }
    
    func handleSignin(authStatus : String){
        if authStatus == "Success" {
            self.performSegue(withIdentifier: "goToUserForm", sender: Any.self)
        } else {
            self.authAlert(message: authStatus)
        }
    }
    
    func validate()->Bool{
        if emailTextField.text?.isEmpty ?? true {
            authAlert(message: "Email is Empty!")
            return false
        }
        
        if passwordTextField.text?.isEmpty ?? true {
            authAlert(message: "you need a password to Signup!")
            return false
        }
        
        if !(emailTextField.text?.isEmail ?? false) {
            authAlert(message: "Please enter a valid email ID!")
            return false
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let formViewController = segue.destination as? UserFormViewController {
            formViewController.isEmail = true
        }
    }
}
