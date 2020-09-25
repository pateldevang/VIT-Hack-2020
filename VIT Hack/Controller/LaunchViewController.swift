//
//  LaunchViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 25/09/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import FirebaseAuth
import GoogleSignIn

class LaunchViewController: UIViewController {
    @IBOutlet weak var launchImage: UIImageView!
    
    var timer = Timer()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVideo()
    }
    
    private func playVideo() {
        let dark = self.traitCollection.userInterfaceStyle == .dark
        let rescource = dark ? "dark" : "light"
        guard let path = Bundle.main.path(forResource: rescource, ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
        
        let duration = player.currentItem?.asset.duration.seconds ?? 0.0
        print("DURATION:",duration)
        timer = Timer.scheduledTimer(withTimeInterval: duration + 1.0, repeats: false, block: { (timer) in
             player.pause()
             timer.invalidate()
            self.setInitialViewController()
         })
    }
    
    //MARK: - Function setting up intial view controller
    func setInitialViewController() {
        
        let loginstatus = UserDefaults.standard.bool(forKey: Keys.login)
        let onboarded = Defaults.onbaorded()
        
        debugLog(message: "Login: \(loginstatus)")
        debugLog(message: "Onboarded: \(onboarded)")
        
        if !onboarded {
            let VC = mainStoryboard.instantiateViewController(withIdentifier: "onbaording") as! OnboardingViewController
            setViewController(VC)
        } else {
            if loginstatus{
                let VC = mainStoryboard.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
                setViewController(VC)
            } else {
                logout()
                let VC = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! UINavigationController
                setViewController(VC)
            }
        }
    }
    
    func setViewController<view : UIViewController>(_ vc : view){
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
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
