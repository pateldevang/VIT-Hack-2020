//
//  UserFormViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class UserFormViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var instituteNameTextField: UITextField!
    @IBOutlet weak var registrationNumberTextField: UITextField!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    
    var newUser = User()
    var isEmail = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        continueButton.bottomShadow()
        addInputAccessoryForTextFields(textFields: [nameTextField,instituteNameTextField,registrationNumberTextField])
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showProgress()
    }
    
    override func viewDidLayoutSubviews() {
        nameTextField.setUnderLine()
        instituteNameTextField.setUnderLine()
        registrationNumberTextField.setUnderLine()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        progressView.layer.sublayers = nil
        unsubscribeFromKeyboardNotifications()
    }
    
    func showProgress(){
        let start : CGFloat = isEmail ? 0.33 : 0.0
        let end : CGFloat = isEmail ? 0.66 : 0.5
        let progress = Progressbar(for: progressView, duration: 2, startValue: start, endValue: end)
        self.progressView.layer.insertSublayer(progress, above: self.progressView.layer)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if validate() {
            proceedToPhone()
        }
    }
    
    func proceedToPhone(){
        newUser.name = nameTextField.text!
        newUser.collegeName = instituteNameTextField.text!
        newUser.regno = registrationNumberTextField.text!
        newUser.mail = getEmail()
        newUser.uid = Defaults.uid()
        newUser.fcmToken = Defaults.fcmToken()
        self.performSegue(withIdentifier: "goToPhone", sender: Any.self)
    }
    
    func validate()->Bool{
        if nameTextField.text?.isEmpty ?? true {
            authAlert(message: "Please enter your name!")
            return false
        }
        
        if instituteNameTextField.text?.isEmpty ?? true {
            authAlert(message: "Which institute are you a part of?")
            return false
        }
        
        if registrationNumberTextField.text?.isEmpty ?? true {
            authAlert(message: "Please enter your registration number")
            return false
        }
        
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPhone" {
            let phoneViewController = segue.destination as! PhoneViewController
            phoneViewController.newUser = self.newUser
            phoneViewController.isEmail = self.isEmail
        }
    }
}

//MARK:- Keyboard show + hide functions
extension UserFormViewController {
    //MARK: Add Observers
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardIsUp), name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardIsDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Remove Observers
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
     @objc func keyboardIsUp(notification: NSNotification) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
     @objc func keyboardIsDown(notification: NSNotification) {
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
}
