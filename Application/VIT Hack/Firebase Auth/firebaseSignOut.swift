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
            UserDefaults.standard.set(true, forKey: Keys.onboard)
            UserDefaults.standard.set(nil, forKey: Keys.uid)
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! UINavigationController
            vc.modalTransitionStyle = .flipHorizontal
            self.present(vc,animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
