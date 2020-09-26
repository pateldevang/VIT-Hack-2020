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
        if let uid = Defaults.uid() {
            self.database.child("users").child(uid).setValue(param) {
                (error:Error?, database:DatabaseReference) in
                if let error = error { // Error Handling
                    debugLog(message: "Data could not be saved: \(error).")
                    completion(false)
                } else {
                    debugLog(message: "Data saved successfully!")
                    completion(true)  // Completion handler
                }
            }
        } else {
            completion(false)  // Completion handler
        }
    }
    
    public func getUser(completion:@escaping (Bool,User)->()){
        var user = User()
        guard let uid = Defaults.uid() else {completion(false,user);return}
        database.child("users").child(uid).observeSingleEvent(of: .value, with:  { (snapshot) in
            print(snapshot)
            // Initializing Eumerator
            let enumerator = snapshot.children.allObjects
            // Adding the data from child snapshots
            if let t1 = enumerator[0] as? DataSnapshot { user.collegeName = t1.value as? String }
            if let t3 = enumerator[2] as? DataSnapshot { user.mail = t3.value as? String }
            if let t4 = enumerator[3] as? DataSnapshot { user.name = t4.value as? String }
            if let t5 = enumerator[4] as? DataSnapshot { user.phone = t5.value as? String }
            if let t6 = enumerator[5] as? DataSnapshot { user.regno = t6.value as? String }
            completion(true,user)
        }){ (error) in // Error Handling
            completion(false, user)
            debugPrint(error.localizedDescription)
        }
    }
    
    public func checkUser(uid:String,completion:@escaping(Bool)->()){
        database.child("users").observeSingleEvent(of: .value) { (snap) in
            if snap.hasChild(uid) {
                completion(true)
            } else {
                completion(false)
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
            ControllerDefaults.saveSponsors(sponsorDataArray, isCollaborator: isCollaborator)
            completion(true, sponsorDataArray)  // Completion handler
        }) { (error) in // Error Handling
            completion(false, sponsorDataArray) 
            debugPrint(error.localizedDescription)
        }
    }
    
    //MARK: - Function to fetch Speakers data (Fetch Once then cache)
    public func getSpeaker(completion: @escaping (Bool, [SpeakersData]) -> ()) {
        // Variables
        var speaker = SpeakersData()
        var speakerDataArray = [SpeakersData]()
        // Observe sponsors child with .childAdded type
        database.child("speakers").observe(DataEventType.childAdded, with: { (snapshot) in
            // Initializing Eumerator
            let enumerator = snapshot.children.allObjects
            // Adding the data from child snapshots
            if let t1 = enumerator[0] as? DataSnapshot { speaker.company = t1.value as? String }
            if let t2 = enumerator[1] as? DataSnapshot { speaker.designation = t2.value as? String }
            if let t3 = enumerator[2] as? DataSnapshot { speaker.endUnix = t3.value as? Double }
            if let t4 = enumerator[3] as? DataSnapshot { speaker.imageUrl = t4.value as? String }
            if let t5 = enumerator[4] as? DataSnapshot { speaker.name = t5.value as? String }
            if let t6 = enumerator[5] as? DataSnapshot { speaker.sessionUrl = t6.value as? String }
            if let t7 = enumerator[6] as? DataSnapshot { speaker.startUnix = t7.value as? Double }
            
            speakerDataArray.append(speaker)  // Appending into sponsorDataArray
            ControllerDefaults.saveSpeakers(speakerDataArray)
            completion(true, speakerDataArray)  // Completion handler
        }) { (error) in // Error Handling
            completion(false, speakerDataArray)
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
                // Appending into FAQDataArray
                FAQDataArray.append(FAQ)
            }
            // Completion handler
            ControllerDefaults.saveFAQs(FAQDataArray)
            completion(true, FAQDataArray)
        }) { (error) in // Error Handling
            completion(false, FAQDataArray)
            debugPrint(error.localizedDescription)
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
            ControllerDefaults.saveTimeline(TimelineDataArray)
            completion(true, TimelineDataArray)
        }) { (error) in // Error Handling
            completion(false, TimelineDataArray)
            debugPrint(error.localizedDescription)
        }
    }
    
    public func getDomains(completion: @escaping (Bool, [DomainData]) -> ()) {
        // Variables
        var domain = DomainData()
        var domainDataArray = [DomainData]()
        // Observe Domains child with .childAdded type
        database.child("domains").observe(DataEventType.childAdded, with: { (snapshot) in
            // Initializing Eumerator
            let enumerator = snapshot.children.allObjects
            // Adding the data from child snapshots
            if let t1 = enumerator[0] as? DataSnapshot { domain.abbreviation = t1.value as? String }
            if let t2 = enumerator[1] as? DataSnapshot { domain.colour = t2.value as? String }
            if let t3 = enumerator[2] as? DataSnapshot { domain.description = t3.value as? String }
            if let t4 = enumerator[3] as? DataSnapshot { domain.domain = t4.value as? String }
            if let t5 = enumerator[4] as? DataSnapshot { domain.icon = t5.value as? String }
            if let t6 = enumerator[5] as? DataSnapshot { domain.problemStatements = t6.value as? [String] }
            
            domainDataArray.append(domain)  // Appending into domainDataArray
            ControllerDefaults.saveTracks(domainDataArray)
            completion(true, domainDataArray)  // Completion handler
        }) { (error) in // Error Handling
            completion(false, domainDataArray)
            debugPrint(error.localizedDescription)
        }
    }
    
    
    //MARK: - Function to ask faq
    public func postQuestion(param: [String:String],completion: @escaping (Bool) -> ()) {
        self.database.child("QFAQs").updateChildValues(param) {
            (error:Error?, database:DatabaseReference) in
            if let error = error { // Error Handling
                debugLog(message: "Data could not be sent: \(error).")
                completion(false)
            } else {
                debugLog(message: "Data sent successfully!")
                completion(true)  // Completion handler
            }
        }
    }
    
    public func updateFCM(token : String){
        guard let uid = Defaults.uid() else { return }
        self.checkUser(uid: uid) { (present) in
            if present{
                self.database.child("users").child(uid).updateChildValues(["fcmToken":token])
            }
        }
    }
    
}
