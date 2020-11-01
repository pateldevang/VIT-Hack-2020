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
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.bottomShadow()
        hideKeyboardWhenTappedAround()
        addInputAccessoryForTextFields(textFields: [emailTextField,passwordTextField])
        loadButton(false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailTextField.setUnderLine()
        passwordTextField.setUnderLine()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showProgress()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loadButton(false)
        progressView.layer.sublayers = nil
    }
    
    func showProgress(){
        let progress = Progressbar(for: progressView, duration: 2, startValue: 0.0, endValue: 0.33)
        self.progressView.layer.insertSublayer(progress, above: self.progressView.layer)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if validate(){
        loadButton(true)
        FirebaseAuth.emailSignIn(email: emailTextField.text!, pass: passwordTextField.text!, completion: handleSignin(authStatus:))
        }
    }
    
    func handleSignin(authStatus : String){
        if authStatus == "Success" {
            self.performSegue(withIdentifier: "goToUserForm", sender: Any.self)
        } else {
            loadButton(false)
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
    
    func loadButton(_ bool : Bool){
        let title = bool ? "Signing Up" : "Continue"
        continueButton.setTitle(title, for: .normal)
        bool ? activity.startAnimating() : activity.stopAnimating()
        activity.isHidden = !bool
        emailTextField.isEnabled = !bool
        passwordTextField.isEnabled = !bool
        
        activity.style = .whiteLarge
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let formViewController = segue.destination as? UserFormViewController {
            formViewController.isEmail = true
        }
    }
}
