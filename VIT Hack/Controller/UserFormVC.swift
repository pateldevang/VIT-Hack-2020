//
//  UserFormVC.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class UserFormVC: UIViewController {
    
    
    //MARK:- Outlets
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var VITianToggleButton: UISwitch!
    @IBOutlet var registrationTextField: UITextField!
    @IBOutlet var roomNoTextField: UITextField!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var registrationStack: UIStackView!
    @IBOutlet var roomStack: UIStackView!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //MARK: - Function to setUp initial view
    func setUp() {
        errorLabel.alpha = 0
        emailTextField.text = getEmail()
        emailTextField.isEnabled = false
    }
    
    // MARK: - Toogle action
    @IBAction func toggleValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            registrationStack.isHidden = false
            roomStack.isHidden = false
        } else{
            registrationStack.isHidden = true
            roomStack.isHidden = true
        }
        errorLabel.text = ""
    }
    
    // MARK: - Function to check regex
    private func regExCheck() -> String?{
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please Fill in ALL The Fields☝🏻"
        }
        if !phoneTextField.text!.isValidPhone{
            return"Please Enter a Valid Phone Number"
        }
        if VITianToggleButton.isOn{
            if !registrationTextField.text!.isRegNo{
                return "Please Enter a Valid Registration Number"
            }
            if !roomNoTextField.text!.isRoomNo{
                return "Please Enter Valid Room Number"
            }
        }
        return nil
    }
    
    
    // MARK: - Function to set parameter
    func setParams() -> [String:Any]?{
        if regExCheck() != nil{
            let error = regExCheck()
            errorLabel.alpha = 1
            errorLabel.text = error!
            return nil
        } else{
            errorLabel.text = ""
            var param : [String:Any]
            let isVitian = VITianToggleButton.isOn
            let FCMToken = "something"
            param = ["name":nameTextField.text!,"mail":getEmail(),"phone":phoneTextField.text!,"isVitian":isVitian,"uid":getUID(),"fcmToken":FCMToken,"company": "not chosen yet"]
            if isVitian {
                let regNo = registrationTextField.text
                let roomNo = roomNoTextField.text
                param["regno"] = regNo
                param["room"] = roomNo
            }
            return param
        }
    }
    
    //MARK: - Set user param action
    @IBAction func doneClicked(_ sender: UIButton) {
        if let params = setParams(){
            firebaseNetworking.shared.fillUserForm(param: params) { (result) in
                if result {
                    print("User data has been saved? ")
                    self.performSegue(withIdentifier: "toCompanyVC", sender: nil)
                }else{
                    self.authAlert(titlepass: "Sorry", message: "Please Try again")
                }
            }
        }
    }
}
