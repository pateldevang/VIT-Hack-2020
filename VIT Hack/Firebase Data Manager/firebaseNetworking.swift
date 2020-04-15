//
//  dataManager.swift
//  VIT Hack
//
//  Created by Devang Patel on 02/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import Firebase

class firebaseNetworking {
    
    //MARK: - variables
    static let shared = firebaseNetworking()
    let database = Database.database().reference()
    let myUID = getUID()
    
    
    //MARK: - Function to fill the user form
    // Use bolow data arrary to pass in fillUserdata form function
    
    //      let data = ["company": "Servify", "fcmToken": "\(getUID())","mail": "\(getEmail())", "name": "Devang", "phone": 9999999999, "isVitan": true, "regno": "18BCE0811", "room": "H955", "uid": getUID()] as [String : Any]
    
    // Example how to use it
    //        firebaseNetworking.shared.fillUserForm(param: data) { (status) in
    //              if status == true {
    //    print("Done Nigga")
    //}
    //else {
    //    print("Fuck you dumbass")
    //}
    //        }
    
    public func fillUserForm(param: Any,completion: @escaping (Bool) -> ()) {
        
        self.database.child("users").child(myUID).setValue(param) {
            (error:Error?, database:DatabaseReference) in
            if let error = error {
                debugLog(message: "Data could not be saved: \(error).")
                completion(false)
            } else {
                debugLog(message: "Data saved successfully!")
                completion(true)
            }
        }
    }
    
    
    //MARK: - Function to fetch Sponsors data
    
    public func getSponsor(completion: @escaping (Array<String>,Array<String>,Array<String>) -> ()) {
        
        var logoURL:[String] = []
        var name:[String] = []
        var pageURL:[String] = []
        database.child("sponsors").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? [String : AnyObject] ?? [:]
            let key = Array(value.keys)
            for i in Range (0 ... key.count-1) {
                let key1 = Array(value)[i].key
                let t = value[key1] as? [String : String] ?? [:]
                name.append(t["name"]!)
                logoURL.append(t["logoUrl"]!)
                pageURL.append(t["pageUrl"]!)
            }
            completion(logoURL, name, pageURL)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
