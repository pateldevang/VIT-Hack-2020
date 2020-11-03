//
//  CollaboratorsCell.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 18/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import Kingfisher

class CollaboratorsCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    func setImage(_ data : String?){
        image.kf.indicatorType = .activity
        
        if let imageUrl =  data ,let url = URL(string: imageUrl){
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

