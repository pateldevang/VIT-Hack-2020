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

import Foundation
import GoogleSignIn
import Firebase

extension HomeViewController : GIDSignInDelegate{
    
    
    public func googleSetup(){
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            //self.removeBlurView()
            //self.activityView.stopAnimating()
            return
        }
        
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let uid = authResult?.user.uid else { return }
            
            print("Sucessfully logged into firebase with Google!",uid)
            
            firebaseNetworking.shared.checkUser(uid, completion: self.handleUser(success:))
        }
    }
    
    func handleUser(success : Bool){
        if success {
            firebaseNetworking.shared.getUser(getUID(), completion: saveUser(status:user:))
        } else {
            self.performSegue(withIdentifier: "apple", sender: nil)
        }
    }
    
    func saveUser(status : Bool, user : User){
        if status {
            Defaults.saveUser(user)
            Defaults.userDefaults.set(true, forKey: Keys.login)
            UIDevice.validVibrate()
            gototabbar()
        } else {
            authAlert(message: "Please try again!")
        }
    }
    
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url)
    }
    
}
