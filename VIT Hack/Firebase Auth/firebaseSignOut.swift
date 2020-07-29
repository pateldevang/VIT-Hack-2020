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
            // Deleting all user Defaults
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
            }
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance().signOut()
            debugLog(message: "SignOut successful")
            self.performSegue(withIdentifier: "logout", sender: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
