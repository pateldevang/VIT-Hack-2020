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
        var appOpenCount = Defaults.appOpenCount()
        appOpenCount += 1
        UserDefaults.standard.set(appOpenCount, forKey: Keys.appOpenCount)
    }
    
    static func checkAndAskForReview() {
        incrementAppOpenedCount()
        
        let appOpenCount = Defaults.appOpenCount()
        
        switch appOpenCount {
        case 5,50:
            StoreReviewHelper().requestReview()
        case _ where appOpenCount%100 == 0 :
            StoreReviewHelper().requestReview()
        default:
            print("App run count is : \(appOpenCount)")
            break
        }
    }
    
    fileprivate func requestReview() {
        SKStoreReviewController.requestReview()
    }
    
}
