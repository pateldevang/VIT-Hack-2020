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
    
    var newUser: User!
    var isEmail = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberTextField.setUnderLine()
        continueButton.bottomShadow()
        setupPhoneField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showProgress()
    }
    
    func setupPhoneField(){
        PhoneNumberKit.CountryCodePicker.commonCountryCodes = ["IN"]
        phoneNumberTextField.withFlag = true
        phoneNumberTextField.withExamplePlaceholder = true
    }
    
    func showProgress(){
        let start : CGFloat = isEmail ? 0.66 : 0.5
        let progress = Progressbar(for: progressView, duration: 2, startValue: start, endValue: 1)
        self.progressView.layer.insertSublayer(progress, above: self.progressView.layer)
    }
    
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if validate(){
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
            performSegue(withIdentifier: "main", sender: nil)
        } else {
            authAlert(message: "Please try again!")
        }
    }
    
    func validate()->Bool{
        let phone = String(phoneNumberTextField?.text?.replacingOccurrences(of: " ", with: "") ?? "")
        if phone.isEmpty {
            authAlert(message: "Phone number missing!")
            return false
        }
        
        if !phoneNumberTextField.isValidNumber{
            authAlert(message: "Phone number invalid")
            return false
        }
        
        return true
    }
}
