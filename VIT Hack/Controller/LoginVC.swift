//
//  LoginVC.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Function for checking newtwork connection
        checkNewtork(ifError: "Cannot login")
    }
    
    // MARK: - Login button action
    @IBAction func loginAction(_ sender: Any) {
        // Check internet connection
        checkNewtork(ifError: "Cannot login")
        
        FirebaseAuth.emailLoginIn(email: "MOFO@g.com", pass: "MOFO!!!") { (result) in
            switch result {
            case "Sucess":
                debugLog(message: "Go to NExt VC")
            default:
                self.authAlert(titlepass: "Error", message: result)
            }
        }
    }
    
    //MARK: - Login with Google action
    @IBAction func googleSignInAction(_ sender: Any) {
        checkNewtork(ifError: "Cannot login")
        gSignIn()
    }
    
    //MARK: - Login with Apple ID action
    @IBAction func appleAction(_ sender: Any) {
        checkNewtork(ifError: "Cannot login")
    }
    
}
