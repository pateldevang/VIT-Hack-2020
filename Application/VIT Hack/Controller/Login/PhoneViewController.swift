//
//  PhoneViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import PhoneNumberKit

class PhoneViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextField: PhoneNumberTextField!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var newUser: User!
    var isEmail = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.bottomShadow()
        setupPhoneField()
        hideKeyboardWhenTappedAround()
        loadButton(false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        phoneNumberTextField.setUnderLine()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showProgress()
    }
    
    func setupPhoneField(){
        phoneNumberTextField.withFlag = true
        phoneNumberTextField.withExamplePlaceholder = true
        if phoneNumberTextField.currentRegion == "IN" {
            phoneNumberTextField.maxDigits = 10
        }
    }
    
    func showProgress(){
        let start : CGFloat = isEmail ? 0.66 : 0.5
        let progress = Progressbar(for: progressView, duration: 2, startValue: start, endValue: 1)
        self.progressView.layer.insertSublayer(progress, above: self.progressView.layer)
    }
    
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if validate(){
             loadButton(true)
            addUser()
        }
    }
    
    func addUser(){
        newUser.phone = String(phoneNumberTextField?.text?.replacingOccurrences(of: " ", with: "") ?? "")
        let params = newUser.asDictionary
        firebaseNetworking.shared.fillUserForm(param: params, completion: handlePostUser(success:))
    }
    
    func handlePostUser(success:Bool){
        if success{
            Defaults.saveUser(newUser)
            Defaults.userDefaults.set(true, forKey: Keys.login)
            gototabbar()
        } else {
            loadButton(false)
            authAlert(message: "Please try again!")
        }
    }
    
    func validate()->Bool{

        if phoneNumberTextField.text?.isEmpty ?? true {
          authAlert(message: "Phone number missing!")
            return false
        }
        
        if !phoneNumberTextField.isValidNumber{
            authAlert(message: "Phone number invalid")
            return false
        }
        
        return true
    }
    
    func loadButton(_ bool : Bool){
        let title = bool ? "Loading..." : "Continue"
        continueButton.setTitle(title, for: .normal)
        bool ? indicator.startAnimating() : indicator.stopAnimating()
        indicator.isHidden = !bool
        phoneNumberTextField.isEnabled = !bool
        
        indicator.style = .whiteLarge
    }
    
}
