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
    
    func setupCell(_ title: [String],_ value:[String],_ indexPath : IndexPath){
        self.title.text = title[indexPath.row]
        self.value.text = value[indexPath.row]
    }
}
