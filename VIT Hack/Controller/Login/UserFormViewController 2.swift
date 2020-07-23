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

    var newUser = User()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func continueButtonPressed(_ sender: Any) {
        guard let name = nameTextField.text else {
            dismissAlert(titlepass: "Name missing", message: "Please enter your name")
            return
        }
        guard let instituteName = instituteNameTextField.text else {
            dismissAlert(titlepass: "Institute Name missing", message: "Please enter your institute's name")
            return
        }
        guard let registrationNumber = registrationNumberTextField.text else {
            dismissAlert(titlepass: "Registration Number missing", message: "Please enter your institute's registration number!")
            return
        }
        newUser.name = name
        newUser.collegeName = instituteName
        newUser.regno = registrationNumber
        newUser.mail = getEmail()
        newUser.uid = getUID()
        do {
            let params = try newUser.asDictionary()
            firebaseNetworking.shared.fillUserForm(param: params) { completion in
                print("STATUS: \(completion)")
            }
        } catch { print(error) }

        self.performSegue(withIdentifier: "goToPhone", sender: Any.self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPhone" {
            let phoneViewController = segue.destination as! PhoneViewController
            phoneViewController.newUser = self.newUser
        }
    }
}
