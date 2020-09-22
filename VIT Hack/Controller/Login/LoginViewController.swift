//
//  LoginViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.setUnderLine()
        passwordTextField.setUnderLine()
        signinButton.bottomShadow()
        hideKeyboardWhenTappedAround()
        addInputAccessoryForTextFields(textFields: [emailTextField,passwordTextField])
        loadButton(false)
    }
    
    @IBAction func signin(_ sender: Any) {
        loadButton(true)
        login()
    }
    
    func login(){
        FirebaseAuth.emailLoginIn(email: emailTextField.text!, pass: passwordTextField.text!, completion: handlelogin(authStatus:))
    }
    
    func handlelogin(authStatus : String){
        if authStatus == "Success" {
            firebaseNetworking.shared.checkUser(getUID(), completion: handleUser(success:))
        } else {
            loadButton(false)
            self.authAlert(message: authStatus)
        }
    }

    
    func handleUser(success : Bool){
        if success {
            firebaseNetworking.shared.getUser(getUID(), completion: saveUser(status:user:))
        } else {
            loadButton(false)
            self.performSegue(withIdentifier: "form", sender: nil)
        }
    }
    
    func saveUser(status : Bool, user : User){
        if status {
            downloadData()
            Defaults.saveUser(user)
            Defaults.userDefaults.set(true, forKey: Keys.login)
            gototabbar()
        } else {
            loadButton(false)
            authAlert(message: "Please try again!")
        }
    }
    
    func validate()->Bool{
        if emailTextField.text?.isEmpty ?? true {
            authAlert(message: "Email is Empty!")
            return false
        }
        
        if passwordTextField.text?.isEmpty ?? true {
            authAlert(message: "you need a password to login!")
            return false
        }
        
        if !(emailTextField.text?.isEmail ?? false) {
            authAlert(message: "Please enter a valid email ID!")
            return false
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let form = segue.destination as? UserFormViewController {
            form.isEmail = false
        }
    }
    
    func loadButton(_ bool : Bool){
        let title = bool ? "Signing In" : "Sign In"
        signinButton.setTitle(title, for: .normal)
        bool ? indicator.startAnimating() : indicator.stopAnimating()
        indicator.isHidden = !bool
        emailTextField.isEnabled = !bool
        passwordTextField.isEnabled = !bool
        
        indicator.style = .whiteLarge
    }
    
}
