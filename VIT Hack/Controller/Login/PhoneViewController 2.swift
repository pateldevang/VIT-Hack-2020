//
//  PhoneViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class PhoneViewController: UIViewController {

    var newUser: User!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
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
