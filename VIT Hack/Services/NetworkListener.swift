//
//  NetworkListener.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 01/09/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation

class NetworkListner : NSObject {
    
    static  let shared = NetworkListner()
    
    var reachabilityStatus: Reachability.Connection = .none
    var reachability = Reachability()
    
    func startListner() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func stopListener() {
        print("Stop Listener")
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        reachability = nil
    }
    
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("REACHABILITY: WIFI")
            StatusBarMessage.show(with: "Wifi Connected", style: .success, duration: 2.0)
        case .cellular:
            print("REACHABILITY: CELLULAR")
            StatusBarMessage.show(with: "Connected", style: .success, duration: 2.0)
        case .none:
            print("REACHABILITY: NONE")
            StatusBarMessage.show(with: "Network unavailable", style: .error, duration: 5.0)
        }
    }
}
