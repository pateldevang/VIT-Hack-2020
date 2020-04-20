//
//  EmailVC.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 18/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class EmailVC: UIViewController {
    

    //MARK:- Outlets
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var navbar: UINavigationBar!
    @IBOutlet var navItem: UINavigationItem!
    
    @IBOutlet var forgotPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    //MARK:- Setup App
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            setTitles("Sign In", false)
        case 1:
            setTitles("Sign Up", true)
        default:
            setTitles("Sign In", false)
        }
    }
    
    func setTitles(_ title : String, _ bool : Bool){
        navItem.title = title
        loginButton.setTitle(title, for: .normal)
         forgotPasswordButton.isHidden = bool
    }
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if segmentedControl.selectedSegmentIndex == 0 {
            logInAction()
        } else {
            signUpAction()
        }
    }
    
    private func logInAction(){
        // Check internet connection
        checkNewtork(ifError: "Cannot login")
        FirebaseAuth.emailLoginIn(email: "a@k.com", pass: "testing") { (result) in
            switch result {
            case "Success":
                self.goToTabbarVC()
                debugLog(message: "Go to TabBarVC")
            default:
                self.authAlert(titlepass: "Error", message: result)
            }
        }
    }
    
    private func signUpAction(){
        FirebaseAuth.emailSignIn(email: "sampleSignup@abc.com", pass: "testing") { (result) in
            switch result {
            case "Success":
                self.goToFormVC()
                debugLog(message: "Going to FormVC")
            default:
                self.authAlert(titlepass: "Error", message: result)
            }
        }
    }
    
    private func goToFormVC(){
        let vc = storyboard!.instantiateViewController(withIdentifier: "UserFormVC") as! UserFormVC
        let presentingController =  self.presentingViewController
        self.dismiss(animated: false) {
            presentingController?.present(vc, animated: false, completion: nil)
        }
    }
    
    private func goToTabbarVC(){
        let tap = mainStoryboard.instantiateViewController(withIdentifier: "tapBar") as! UITabBarController
        appDelegate.window?.rootViewController = tap
        appDelegate.window?.makeKeyAndVisible()
    }
}
