//
//  HomeViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 14/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import AuthenticationServices
import GoogleSignIn

class HomeViewController: UIViewController {
    
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    // Unhashed nonce.
    var currentNonce: String?
    let activityView = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleSetup()
        hideNavbar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeBlurView()
    }
    
    
    @IBAction func google(_ sender: Any) {
        blurView()
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func apple(_ sender: Any) {
        if #available(iOS 13, *) {
            blurView()
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
    
    func blurView(){
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.light))
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        activityView.center = self.view.center
        activityView.tintColor = .white
        view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func removeBlurView(){
        for subview in view.subviews {
            if subview is UIVisualEffectView || subview is UIActivityIndicatorView{
                subview.removeFromSuperview()
            }
        }
        activityView.stopAnimating()
    }
    
}

