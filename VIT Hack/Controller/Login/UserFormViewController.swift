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
    var textfieldBottom : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        continueButton.bottomShadow()
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showProgress()
        nameTextField.setUnderLine()
        instituteNameTextField.setUnderLine()
        registrationNumberTextField.setUnderLine()
    }
    
    override func viewDidLayoutSubviews() {
        let frame = registrationNumberTextField.convert(view.frame, from:view).maxY
        textfieldBottom = (textfieldBottom == 0.0) ? frame : textfieldBottom
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
        newUser.uid = getUID()
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    //MARK: Remove Observers
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    //MARK: Move stackView based on keybaord
    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        //MARK: Get Keboard Y point on screen
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        
        //MARK: Get keyboard display time
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        
        //MARK: Set animations
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        // MARK: Get Keyboard Top Inset
        let viewHeight = UIScreen.main.bounds.height
        let keyboardIsUp = endFrameY == viewHeight
        
        let diff = (viewHeight - endFrameY) - textfieldBottom + 35
        let offset : CGFloat = diff>0 ? (keyboardIsUp ? 0 : diff) : 0
        
        UIView.animate(withDuration: duration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: { self.view.layoutIfNeeded(); self.view.frame.origin.y = -offset },
                       completion: nil)
    }
}
