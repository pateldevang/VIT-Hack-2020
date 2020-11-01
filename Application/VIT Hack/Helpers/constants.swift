//
//  constants.swift
//  VIT Hack
//
//  Created by Devang Patel on 02/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import Firebase

let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

//MARK: -  function to get Registred Email
internal func getEmail() -> String {
    let userEmail = Auth.auth().currentUser?.email
    return userEmail ?? "notFound"
}


public func debugLog(message: String) {
    #if DEBUG
    debugPrint("=======================================")
    debugPrint(message)
    debugPrint("=======================================")
    #endif
}

struct Social {
    static let discord = "https://discord.gg/UX26KdG"
    static let privacyPolicy = "https://firebasestorage.googleapis.com/v0/b/project-vithack.appspot.com/o/Docs%2FiOS_privacy_policy.pdf?alt=media&token=c2020ff4-37ec-40c5-a759-584439de2209"
    static let vitHackSocials = ["https://www.linkedin.com/company/hackvit/","https://www.instagram.com/vithack2020/","https://twitter.com/VITHack2020/","https://www.facebook.com/vithack19/"]
}

struct Keys {
    static let uid = "uid"
    static let name = "name"
    static let institute = "institute"
    static let registration = "registration"
    static let login = "login"
    static let fcmToken = "fcmToken"
    static let onboard = "onbaord"
    static let network = "network"
    static let appOpenCount = "appOpenCount"
    static let hackStarted = "hackStarted"
}

struct ControllerKeys {
    static let timeline = "timeline"
    static let faq = "faq"
    static let tracks = "tracks"
    
    static let sponsor = "sponsor"
    static let speaker = "speaker"
    static let collaborator = "collaborator"
}
