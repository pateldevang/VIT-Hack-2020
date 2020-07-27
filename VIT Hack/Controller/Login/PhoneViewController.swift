//
//  PhoneViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class PhoneViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    var newUser: User!
    var isEmail = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberTextField.setUnderLine()
        continueButton.bottomShadow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showProgress()
    }
    
    func showProgress(){
        let start : CGFloat = isEmail ? 0.66 : 0.5
        let progress = Progressbar(for: progressView, duration: 2, startValue: start, endValue: 1)
        self.progressView.layer.insertSublayer(progress, above: self.progressView.layer)
    }
    
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        guard let phoneNumber = phoneNumberTextField.text else {
            dismissAlert(titlepass: "Phone missing", message: "Please enter your phone number")
            return
        }
        newUser.phone = phoneNumber
        do {
            let params = try newUser.asDictionary()
            firebaseNetworking.shared.fillUserForm(param: params) { completion in
                print("STATUS: \(completion)")
            }
        } catch { print(error) }
    }
}
