//
//  HomeViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 14/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import GoogleSignIn

class HomeViewController: UIViewController {
    
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    // Unhashed nonce.
    var currentNonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleSetup()
        appleButton.bottomShadow()
        googleButton.bottomShadow()
        emailButton.bottomShadow()
        hideNavbar()
    }
    
    
    @IBAction func google(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func apple(_ sender: Any) {
        if #available(iOS 13, *) {
            appleSignin()
        } else {
            authAlert(message: "iOS 13.0 or greater required.")
        }
    }
    
    
    func hideNavbar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }

    @IBAction func unwindToHome(segue:UIStoryboardSegue) { }
}

