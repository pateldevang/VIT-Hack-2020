//
//  ProfileCell.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 20/09/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var value: UILabel!
    
    func setupCell(_ data: [String:String],_ indexPath : IndexPath){
        title.text = Array(data.keys)[indexPath.row]
        value.text = Array(data.values)[indexPath.row]
    }
}
