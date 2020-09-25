//
//  TimelineData.swift
//  VIT Hack
//
//  Created by Devang Patel on 17/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation

struct TimelineData : Codable{
    var endUnix:Double?
    var link : String?
    var startUnix:Double?
    var subtitle:String?
    var title:String?
    
    var day : Int {
        if let start = startUnix{
            let startDate = Date(timeIntervalSince1970: start)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            guard let day1 = formatter.date(from: "2020/10/09 00:00") else {return 0}
            guard let day2 = formatter.date(from: "2020/10/10 00:00") else {return 0}
            guard let day3 = formatter.date(from: "2020/10/11 00:00") else {return 0}
            switch startDate {
            case day1..<day2:
                return 1
            case day2..<day3:
                return 2
            case _ where startDate > day3:
                return 3
            default:
                return 0
            }
        } else {
            return 0
        }
    }
}
