//
//  firebaseSignOut.swift
//  VIT Hack
//
//  Created by Devang Patel on 02/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

extension UIViewController {
    
    //MARK: - Signout settings
    func signOut() {
        
        let firebaseAuth = Auth.auth()
        do {
            // Set initial user default for login as false
            UserDefaults.standard.set(false, forKey: "login")
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance().signOut()
            debugLog(message: "SignOut successful")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "navVC") as! UINavigationController
            self.present(controller, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
