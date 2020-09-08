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
            StatusBarMessage.show(with: "Wifi Connected", color: #colorLiteral(red: 0.2941176471, green: 0.7098039216, blue: 0.262745098, alpha: 1), duration: 2.0)
        case .cellular:
            print("REACHABILITY: CELLULAR")
            StatusBarMessage.show(with: "Connected", color: #colorLiteral(red: 0.2941176471, green: 0.7098039216, blue: 0.262745098, alpha: 1), duration: 2.0)
        case .none:
            print("REACHABILITY: NONE")
            StatusBarMessage.show(with: "Network unavailable", color: #colorLiteral(red: 1, green: 0.3575092515, blue: 0.3653251075, alpha: 1), duration: 5.0)
        }
    }
    
}
