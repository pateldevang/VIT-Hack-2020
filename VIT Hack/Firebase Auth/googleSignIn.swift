//
//  File.swift
//  VIT Hack
//
//  Created by Devang Patel on 15/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn


extension AppDelegate: GIDSignInDelegate{
    
    // Open URL for GoogleSignIn
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    // GoogleSignIn setting up app delegate methods
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            debugLog(message: ("\(error)"))
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        debugLog(message: "\(credential)")
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            guard let uid = user.userID else { return }
            print(uid)
            debugLog(message: "Successfully logged into firebase with Google!")
            
            
            // Access the storyboard and fetch an instance of the view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil);
            let viewController: UserFormVC = storyboard.instantiateViewController(withIdentifier: "UserFormVC") as! UserFormVC
            
            // Then push that view controller onto the navigation stack
            let rootViewController = self.window!.rootViewController
            rootViewController?.show(viewController, sender: true)
            // Haptic feedback when logged in
            UIDevice.validVibrate()
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
}
