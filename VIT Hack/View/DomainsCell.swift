//
//  DomainsCell.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class DomainsCell: UICollectionViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var showMore: UIButton!
    @IBOutlet weak var card: UIView!
    
    func setupCell(_ data : DomainData){
        header.text = data.title
        body.text = data.body
        icon.image = data.Image
        card.backgroundColor = data.color
        card.layer.cornerRadius = 16
        shadow()
    }
    
    func shadow(){
        layer.cornerRadius = 24
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 24
        layer.shadowOpacity = 1
        layer.masksToBounds = false
    }
}
