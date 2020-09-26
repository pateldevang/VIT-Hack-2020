//
//  StoreReviewHelper.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 25/09/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import StoreKit

struct StoreReviewHelper {
    static func incrementAppOpenedCount() {
        if Defaults.onbaorded() && Defaults.isLogin(){
            var appOpenCount = Defaults.appOpenCount()
            appOpenCount += 1
            UserDefaults.standard.set(appOpenCount, forKey: Keys.appOpenCount)
        }
    }
    
    static func checkAndAskForReview() {
        
        let appOpenCount = Defaults.appOpenCount()
        switch appOpenCount {
        case 10,50:
            StoreReviewHelper().requestReview()
        case _ where appOpenCount%100 == 0 :
            StoreReviewHelper().requestReview()
        default:
            if StoreReviewHelper().hackStarted(){
                StoreReviewHelper().requestReview()
                UserDefaults.standard.set(false, forKey: Keys.hackStarted)
            }
            print("App run count is : \(appOpenCount)")
            break
        }
        
    }
    
    fileprivate func hackStarted()->Bool{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let hackOn = formatter.date(from: "2020/10/09 16:20") else {return false}
        let bool = Defaults.hackStartReview()
        return (hackOn < Date()) && bool
    }
    
    fileprivate func requestReview() {
        SKStoreReviewController.requestReview()
    }
    
}
