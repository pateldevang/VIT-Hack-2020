//
//  ViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 29/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit


extension UIViewController {
    func gototabbar(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            let vc = storyboard.instantiateViewController(identifier: "tabbar") as! UITabBarController
            self.present(vc, animated: true)
        } else {
            let vc = storyboard.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
            self.present(vc, animated: true)
        }
        
    }
    
    func downloadData(){
        firebaseNetworking.shared.getTimeline { (_, _) in }
        firebaseNetworking.shared.getDomains { (_, _) in }
        firebaseNetworking.shared.getFAQ { (_, _) in }
        firebaseNetworking.shared.getSponsor { (_, _) in }
        firebaseNetworking.shared.getSpeaker { (_, _) in }
        firebaseNetworking.shared.getSponsor(isCollaborator: true) { (_, _) in }
    }
}
