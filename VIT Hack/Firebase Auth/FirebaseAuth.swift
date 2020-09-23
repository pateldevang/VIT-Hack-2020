//
//  FirebaseAuth.swift
//  VIT Hack
//
//  Created by Devang Patel on 02/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import FirebaseAuth


class FirebaseAuth: UIViewController {
    
    
    //MARK: - Function for Login using email and password
    public static func emailLoginIn(email: String, pass: String, completion: @escaping (String,String) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error)
            in
            if error != nil {
                // Haptic on errors
                UIDevice.invalidVibrate()
                debugLog(message: error?.localizedDescription ?? "Error")
                switch error?.localizedDescription ?? "Error" {
                case "The email address is badly formatted.":
                    completion(error?.localizedDescription ?? "Error", "")
                case "The password is invalid or the user does not have a password.":
                    completion(error?.localizedDescription ?? "Error", "")
                case "There is no user record corresponding to this identifier. The user may have been deleted.":
                    completion("There is no user registered to this Email ID.", "")
                default:
                    completion("Contact Developer", "")
                }
            }
            else{
                if let uid = user?.user.uid{
                    // Haptic on valid
                    UIDevice.validVibrate()
                    UserDefaults.standard.set(uid, forKey: Keys.uid)
                    completion("Success", uid)
                } else {
                    completion("Contact Developer", "")
                }
            }
        }
    }
    
    
    // MARK: - Function for Sign-In using email and password
    public static func emailSignIn(email: String, pass: String, completion: @escaping (String) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: pass) { (authResult, error)
            in
            if error != nil {
                // Vibrates on errors
                UIDevice.invalidVibrate()
                debugLog(message: error?.localizedDescription ?? "Error")
                switch error?.localizedDescription ?? "Error" {
                case "The password must be 6 characters long or more.":
                    completion(error?.localizedDescription ?? "Error")
                case "The email address is already in use by another account.":
                    completion(error?.localizedDescription ?? "Error")
                default:
                    completion("Contact Developer")
                }
            }
            else {
                // Vibrates on valid
                UIDevice.validVibrate()
                UserDefaults.standard.set(authResult?.user.uid, forKey: Keys.uid)
                completion("Success")
            }
        }
    }
    
    //MARK: - Function for forget password using registered Email-ID
    public static func forgetPassword(email: String, completion: @escaping (String) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                // Vibrates on errors
                UIDevice.invalidVibrate()
                debugLog(message: error?.localizedDescription ?? "Error")
                switch error?.localizedDescription ?? "Error" {
                case "The email address is badly formatted.":
                    completion(error?.localizedDescription ?? "Error")
                case "There is no user record corresponding to this identifier. The user may have been deleted.":
                    completion("There is no user registered to this Email ID.")
                default:
                    completion("Contact Developer")
                }
            }
            else {
                // Vibrates on valid
                UIDevice.validVibrate()
                completion("Success")
            }
        }
    }
}
