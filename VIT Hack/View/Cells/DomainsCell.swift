//
//  DomainsCell.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import Kingfisher

class DomainsCell: UICollectionViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var showMore: UIButton!
    @IBOutlet weak var card: UIView!
    
    func setupCell(_ data : DomainData){
        setImage(data)
        header.text = data.domain
        body.text = data.description
        card.backgroundColor = UIColor(hex: data.colour ?? "#ADDAFF")
        card.layer.cornerRadius = 16
        shadow()
    }
    
    func setImage(_ data : DomainData){
        icon.kf.indicatorType = .activity
        
        if let imageUrl =  data.icon ,let url = URL(string: imageUrl){
            icon.kf.setImage(
                with: url,
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
            ])
        }
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
