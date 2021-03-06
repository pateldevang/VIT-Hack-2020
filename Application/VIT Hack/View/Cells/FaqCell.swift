//
//  FaqCell.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 05/08/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class FaqCell: UITableViewCell {
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var card: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadow(card)
    }
    
    
    func shadow(_ view : UIView){
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 24
        view.layer.shadowOpacity = 1
        view.layer.masksToBounds = false
    }
    
}
