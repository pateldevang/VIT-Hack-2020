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

//MARK: -  function to get uid
internal func getUID() -> String {
    let uid = Auth.auth().currentUser?.uid
    return uid ?? "notFound"
}

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

struct Keys {
    static let name = "name"
    static let institute = "institute"
    static let registration = "registration"
    static let login = "login"
    static let fcmToken = "fcmToken"
    static let onboard = "onbaord"
}

struct ControllerKeys {
    static let timeline = "timeline"
    static let faq = "faq"
    static let tracks = "tracks"
    
    static let sponsor = "sponsor"
    static let speaker = "speaker"
    static let collaborator = "collaborator"
}
