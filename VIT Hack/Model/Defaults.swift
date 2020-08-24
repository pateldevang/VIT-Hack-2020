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
    
    static func fcmToken() -> String {
        return (userDefaults.value(forKey: Keys.fcmToken) as? String) ?? ""
    }
    
    static func saveUser(_ user : User){
        userDefaults.set(user.name, forKey: Keys.name)
        userDefaults.set(user.regno, forKey: Keys.registration)
        userDefaults.set(user.collegeName, forKey: Keys.institute)
    }
    
    static func onbaorded() -> Bool {
        return (userDefaults.value(forKey: Keys.onboard) as? Bool) ?? false
    }
}


class ControllerDefaults
{
    
    static var userDefaults = UserDefaults.standard
    
    static func saveTimeline(_ timeline : [TimelineData]){
        if let data = try? JSONEncoder().encode(timeline){
            userDefaults.set(data, forKey: ControllerKeys.timeline)
        }
    }
    
    static func saveFAQs(_ faq : [FAQData]){
        if let data = try? JSONEncoder().encode(faq){
            userDefaults.set(data, forKey: ControllerKeys.faq)
        }
    }
    
    static func saveTracks(_ track : [DomainData]){
        if let data = try? JSONEncoder().encode(track){
            userDefaults.set(data, forKey: ControllerKeys.tracks)
        }
    }
    
    static func saveSpeakers(_ speaker : [SpeakersData]){
        if let data = try? JSONEncoder().encode(speaker){
            userDefaults.set(data, forKey: ControllerKeys.speaker)
        }
    }
    
    static func saveSponsors(_ sponsor : [SponsorData], isCollaborator : Bool = false){
        let key = isCollaborator ? ControllerKeys.collaborator : ControllerKeys.sponsor
        if let data = try? JSONEncoder().encode(sponsor){
            userDefaults.set(data, forKey: key)
        }
    }
    
    static func timeline() -> [TimelineData]?{
        if let data = userDefaults.value(forKey: ControllerKeys.timeline) as? Data, let timeline = try?  JSONDecoder().decode([TimelineData].self, from: data){
            return timeline
        }
        return nil
    }
    
    static func FAQ() -> [FAQData]?{
        if let data = userDefaults.value(forKey: ControllerKeys.faq) as? Data, let faq = try?  JSONDecoder().decode([FAQData].self, from: data){
            return faq
        }
        return nil
    }
    
    static func tracks() -> [DomainData]?{
        if let data = userDefaults.value(forKey: ControllerKeys.tracks) as? Data, let tracks = try?  JSONDecoder().decode([DomainData].self, from: data){
            return tracks
        }
        return nil
    }
    
    static func sponsors() -> [SponsorData]?{
        if let data = userDefaults.value(forKey: ControllerKeys.sponsor) as? Data, let sponsors = try?  JSONDecoder().decode([SponsorData].self, from: data){
            return sponsors
        }
        return nil
    }
    
    static func collaborators() -> [SponsorData]?{
        if let data = userDefaults.value(forKey: ControllerKeys.collaborator) as? Data, let collaborator = try?  JSONDecoder().decode([SponsorData].self, from: data){
            return collaborator
        }
        return nil
    }
    
    static func speakers() -> [SpeakersData]?{
        if let data = userDefaults.value(forKey: ControllerKeys.speaker) as? Data, let speaker = try?  JSONDecoder().decode([SpeakersData].self, from: data){
            return speaker
        }
        return nil
    }
    
}
