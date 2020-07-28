//
//  Defaults.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class Defaults
{
    static var userDefaults = UserDefaults.standard

    static func name() -> String {
        return (userDefaults.value(forKey: Keys.name) as? String) ?? ""
    }
    
    static func registration() -> String {
        return (userDefaults.value(forKey: Keys.registration) as? String) ?? ""
    }
    
    static func institute() -> String {
        return (userDefaults.value(forKey: Keys.institute) as? String) ?? ""
    }
    
    static func isLogin() -> Bool {
        return (userDefaults.value(forKey: Keys.login) as? Bool) ?? false
    }
    
    static func saveUser(_ user : User){
        userDefaults.set(user.name, forKey: Keys.name)
        userDefaults.set(user.regno, forKey: Keys.registration)
        userDefaults.set(user.collegeName, forKey: Keys.institute)
    }
}

