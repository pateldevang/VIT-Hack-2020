//
//  TracksCell.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class TracksCell: UITableViewCell {
    
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadow()
    }
    
    
    func shadow(){
        layer.cornerRadius = 24
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 24
        layer.shadowOpacity = 1
        layer.masksToBounds = false
    }
}
