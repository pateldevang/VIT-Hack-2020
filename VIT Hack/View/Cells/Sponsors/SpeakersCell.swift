//
//  SpeakersCell.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 18/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import Kingfisher

class SpeakersCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var join: UIButton!
    
    
    func setupCell(_ data : SpeakersData){
        name.text = data.name
        designation.text = data.designation
        company.text = data.company
        setImage(data)
        join.layer.cornerRadius = 4
    }
    
    func setImage(_ data : SpeakersData){
        image.kf.indicatorType = .activity
        
        if let imageUrl =  data.imageUrl ,let url = URL(string: imageUrl){
            image.kf.setImage(
                with: url,
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
            ])
        }
    }
    
}
