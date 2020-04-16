//
//  dataManager.swift
//  VIT Hack
//
//  Created by Devang Patel on 02/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON

class firebaseNetworking {
    
    //MARK: - variables
    static let shared = firebaseNetworking()
    let database = Database.database().reference()
    let myUID = getUID()
    
    
    //MARK: - Function to fill the user form
    
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
            debugPrint(error.localizedDescription)
        }
    }
    
    
    //MARK: - Function to get FAQ's
    public func getFAQ(completion: @escaping (Bool, FAQData) -> ()) {
        var FAQ = FAQData()
        database.child("FAQs").observe(DataEventType.value, with: { (snapshot) in
            let json = JSON((snapshot.value as? NSArray) as Any)
            for i in 0...json.count-1 {
                FAQ.question.append(json[i]["question"].stringValue)
                FAQ.answer.append(json[i]["answer"].stringValue)
                FAQ.tagZero.append(json[i]["tags"][0].stringValue)
                FAQ.tagOne.append(json[i]["tags"][1].stringValue)
            }
            completion(true, FAQ)
        }) { (error) in
            completion(false, FAQ)
            debugPrint(error.localizedDescription)
        }
    }
    
}
