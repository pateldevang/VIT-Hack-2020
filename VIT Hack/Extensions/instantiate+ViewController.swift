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

extension AppDelegate {
    
    //TODO: - After finalising
    
//    // Function setting up intial view controller
//    func setInitialViewController() {
//
//        // app delegate setup
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//
//
//        let loginstatus = UserDefaults.standard.bool(forKey: "login")
//        print("Login status=\(loginstatus)")
//        if loginstatus == false {
//            let firebaseAuth = Auth.auth()
//            do {
//                try firebaseAuth.signOut()
//                print("SignOut sucessful")
//            } catch let signOutError as NSError {
//                print ("Error signing out: %@", signOutError)
//            }
//            let VC = mainStoryboard.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
//            appDelegate.window?.rootViewController = VC
//            appDelegate.window?.makeKeyAndVisible()
//        }
//        else if loginstatus == true {
//            let tap = mainStoryboard.instantiateViewController(withIdentifier: "tapBar") as! UITabBarController
//            appDelegate.window?.rootViewController = tap
//            appDelegate.window?.makeKeyAndVisible()
//        }
//
//    }
//
}
