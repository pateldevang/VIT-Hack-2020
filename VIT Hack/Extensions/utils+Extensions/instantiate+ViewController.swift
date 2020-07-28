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
//import GoogleSignIn

//TODO
//extension AppDelegate {
//
//    //MARK: - Function setting up intial view controller
//    func setInitialViewController() {
//
//        // app delegate setup
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//        // Get UID function
//        debugLog(message: getUID())
//
//        let loginstatus = UserDefaults.standard.bool(forKey: "login")
//        debugLog(message: "Login status=\(loginstatus)")
//        if loginstatus == false {
//            let firebaseAuth = Auth.auth()
//            do {
//                try firebaseAuth.signOut()
//                GIDSignIn.sharedInstance().signOut()
//                debugLog(message: "SignOut successful")
//            } catch let signOutError as NSError {
//                print ("Error signing out: %@", signOutError)
//            }
//            let VC = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
//            appDelegate.window?.rootViewController = VC
//            appDelegate.window?.makeKeyAndVisible()
//        }
//        else if loginstatus == true {
//            let tap = mainStoryboard.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
//            appDelegate.window?.rootViewController = tap
//            appDelegate.window?.makeKeyAndVisible()
//        }
//    }
//
//}

