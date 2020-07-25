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
    
    // Initializing class
    init() {
        let connectedRef = Database.database().reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { snapshot in
            if let connected = snapshot.value as? Bool , connected {
                // internet connected
                // later banner alert will be added
                print("Connected")
            } else {
                // internet disconnected
                // banner alert
                print("FUCK")
                self.database.removeAllObservers()
            }
        })
    }
    // deinitializing class
    deinit {
        // remove all observer to free memory
        self.database.removeAllObservers()
    }
    
    //MARK: - Function to fill the user form
    public func fillUserForm(param: Any,completion: @escaping (Bool) -> ()) {
        // setValue with param = ["name": "yourName", ....] type
        self.database.child("users").child(myUID).setValue(param) {
            (error:Error?, database:DatabaseReference) in
            if let error = error { // Error Handling
                debugLog(message: "Data could not be saved: \(error).")
                completion(false)
            } else {
                debugLog(message: "Data saved successfully!")
                completion(true)  // Completion handler
            }
        }
    }
    
    //MARK: - Function to update company name
    public func updateCompanyName(companyName: String,completion: @escaping (Bool) -> ()) {
        let ref = database.child("users").child(getUID())
        ref.updateChildValues(["company" : companyName])
        {
            (error:Error?, database:DatabaseReference) in
            if let error = error { // Error Handling
                debugLog(message: "Data could not be saved: \(error).")
                completion(false)
            } else {
                debugLog(message: "Data saved successfully!")
                completion(true)  // Completion handler
            }
        }
    }
    
    
    //MARK: - Function to fetch Sponsors data (Fetch Once then cache)
    public func getSponsor(isCollaborator : Bool = false,completion: @escaping (Bool, [SponsorData]) -> ()) {
        // Variables
        var sponsor = SponsorData()
        var sponsorDataArray = [SponsorData]()
        // Observe sponsors child with .childAdded type
        let child = isCollaborator ? "collaborators" : "sponsors"
        database.child(child).observe(DataEventType.childAdded, with: { (snapshot) in
            // Initializing Eumerator
            let enumerator = snapshot.children.allObjects
            // Adding the data from child snapshots
            if let t1 = enumerator[0] as? DataSnapshot { sponsor.logoUrl = t1.value as? String }
            if let t2 = enumerator[1] as? DataSnapshot { sponsor.name = t2.value as? String }
            if let t3 = enumerator[2] as? DataSnapshot { sponsor.pageUrl = t3.value as? String }
            sponsorDataArray.append(sponsor)  // Appending into sponsorDataArray
            completion(true, sponsorDataArray)  // Completion handler
        }) { (error) in // Error Handling
            completion(false, sponsorDataArray) 
            debugPrint(error.localizedDescription)
        }
    }
    
    
    //MARK: - Function to get FAQ's (Fetch everytime when data changes)
    public func getFAQ(completion: @escaping (Bool, [FAQData]) -> ()) {
        // Variables
        var FAQ = FAQData()
        var FAQDataArray = [FAQData]()
        // Observe FAQs child with .value type
        database.child("FAQs").observe(DataEventType.value, with: { (snapshot) in
            // Making Array empty to avoid duplicate entry when value changes
            FAQDataArray = []
            // Initializing Eumerator
            let enumer = snapshot.children
            // nextObject() calls next child
            while let enumerator = enumer.nextObject() as? DataSnapshot {
                // enumerator for all objects
                let all = enumerator.children.allObjects
                // Adding the data from child snapshots
                if let answer = all[0] as? DataSnapshot { FAQ.answer = answer.value as? String }
                if let question = all[1] as? DataSnapshot { FAQ.question = question.value as? String }
                if let tag = all[2] as? DataSnapshot {
                    let j = JSON(tag.value as Any)
                    FAQ.tagZero = j[0].stringValue
                    FAQ.tagOne = j[1].stringValue
                }
                // Appending into FAQDataArray
                FAQDataArray.append(FAQ)
            }
            // Completion handler
            completion(true, FAQDataArray)
        }) { (error) in // Error Handling
            completion(false, FAQDataArray)
            debugPrint(error.localizedDescription)
        }
    }
    
    
    //MARK: - Function to get Company details (Fetch once)
    public func getCompanyDetails(completion: @escaping (Bool, [CompanyData]) -> ()) {
        // Variables
        var company = CompanyData()
        var companyDataArray = [CompanyData]()
        // Observe company child with .childAdded type
        database.child("company").observe(DataEventType.childAdded, with:
            { (snapshot) in
                // Initializing Eumerator
                let enumerator = snapshot.children.allObjects
                // Adding the data from child snapshots
                if let t1 = enumerator[0] as? DataSnapshot { company.description = t1.value as? String }
                if let t2 = enumerator[1] as? DataSnapshot { company.logoUrl = t2.value as? String }
                if let t3 = enumerator[2] as? DataSnapshot { company.name = t3.value as? String }
                if let t4 = enumerator[3] as? DataSnapshot { company.pageUrl = t4.value as? String }
                if let t5 = enumerator[4] as? DataSnapshot { company.venue = t5.value as? String }
                companyDataArray.append(company)  // Appending into companyDataArray
                completion(true, companyDataArray)  // Completion handler
        }) { (error) in // Error Handling
            debugPrint(error.localizedDescription)
            completion(false, companyDataArray)
        }
    }
    
    //MARK: - Function to get prize data (Fetch once)
    public func getPrize(companyName:String, completion: @escaping (Bool, [PrizeData]) -> ()) {
        // Variables
        var prize = PrizeData()
        var prizeDataArray = [PrizeData]()
        // Observe prize child with .childAdded type
        database.child("prizes/\(companyName)").observe(DataEventType.childAdded, with:
            { (snapshot) in
                // Initializing Eumerator
                let enumerator = snapshot.children.allObjects
                // Adding the data from child snapshots
                if let name = enumerator[0] as? DataSnapshot { prize.name = name.value as? String }
                if let winnable = enumerator[1] as? DataSnapshot { prize.winnable = winnable.value as? String }
                prizeDataArray.append(prize)  // Appending into prizeDataArray
                completion(true, prizeDataArray)  // Completion handler
        }) { (error) in // Error Handling
            debugPrint(error.localizedDescription)
            completion(false, prizeDataArray)
        }
    }
    
    //MARK: - Function to get timeline (Fetch everytime when data changes)
    public func getTimeline(completion: @escaping (Bool, [TimelineData]) -> ()) {
        // Variables
        var timeline = TimelineData()
        var TimelineDataArray = [TimelineData]()
        // Observe timeline child with .value type
        database.child("timeline").observe(DataEventType.value, with: { (snapshot) in
            // Making Array empty to avoid duplicate entry when value changes
            TimelineDataArray = []
            // Initializing Eumerator
            let enumer = snapshot.children
            // nextObject() calls next child
            while let enumerator = enumer.nextObject() as? DataSnapshot {
                // enumerator for all objects
                let all = enumerator.children.allObjects
                // Adding the data from child snapshots
                if let end = all[0] as? DataSnapshot { timeline.endUnix = end.value as? Double }
                if let link = all[1] as? DataSnapshot { timeline.link = link.value as? String }
                if let start = all[2] as? DataSnapshot { timeline.startUnix = start.value as? Double }
                if let subtitle = all[3] as? DataSnapshot { timeline.subtitle = subtitle.value as? String }
                if let title = all[4] as? DataSnapshot { timeline.title = title.value as? String }
                // Appending into TimelineDataArray
                TimelineDataArray.append(timeline)
            }
            // Completion handler
            completion(true, TimelineDataArray)
        }) { (error) in // Error Handling
            completion(false, TimelineDataArray)
            debugPrint(error.localizedDescription)
        }
    }
    
    // TODO: - function for getting tracks [After finalizing schema]
    public func getTracks() {
        
    }
}
