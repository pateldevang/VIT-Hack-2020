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
        nameTextField.setUnderLine()
        instituteNameTextField.setUnderLine()
        registrationNumberTextField.setUnderLine()
        hideKeyboardWhenTappedAround()
        continueButton.bottomShadow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showProgress()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        progressView.layer.sublayers = nil
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
        newUser.uid = getUID()
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
