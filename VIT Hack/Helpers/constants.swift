//
//  constants.swift
//  VIT Hack
//
//  Created by Devang Patel on 02/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import Firebase

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