//
//  UserModel.swift
//  VIT Hack
//
//  Created by Garima Bothra on 16/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation

struct User: Encodable {
    var name: String?
    var mail: String?
    var uid: String?
    var collegeName: String?
    var regno: String?
    var phone: String?
    var fcmToken : String?
    
    var asDictionary : [String:String]{
        return ["uid": getUID(),
                "regno": regno ?? "",
                "collegeName": collegeName ?? "",
                "phone": phone ?? "",
                "name": name ?? "",
                "mail": mail ?? "",
                "fcmToken": fcmToken ?? "",
                "selectedDomain" : ""]
    }
}
