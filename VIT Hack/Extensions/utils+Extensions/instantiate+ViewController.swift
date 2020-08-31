//
//  instantiate+ViewController.swift
//  VIT Hack
//
//  Created by Devang Patel on 02/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

extension AppDelegate {
    
    //MARK: - Function setting up intial view controller
    func setInitialViewController() {
        
        
        // app delegate setup
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Get UID function
        debugLog(message: getUID())
        
        let loginstatus = UserDefaults.standard.bool(forKey: Keys.login)
        let onboarded = Defaults.onbaorded()
        
        debugLog(message: "Login: \(loginstatus)")
        debugLog(message: "Onboarded: \(onboarded)")
        
        if !onboarded {
            let VC = mainStoryboard.instantiateViewController(withIdentifier: "onbaording") as! OnboardingViewController
            appDelegate.window?.rootViewController = VC
            appDelegate.window?.makeKeyAndVisible()
        } else {
            if loginstatus{
                let VC = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! UINavigationController
                appDelegate.window?.rootViewController = VC
                appDelegate.window?.makeKeyAndVisible()
                VC.gototabbar()
            } else {
                logout()
                let VC = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! UINavigationController
                appDelegate.window?.rootViewController = VC
                appDelegate.window?.makeKeyAndVisible()
                
            }
        }
    }
    
    func logout(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance().signOut()
            debugLog(message: "SignOut successful")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}

