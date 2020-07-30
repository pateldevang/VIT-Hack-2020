//
//  OnboardingCell.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 16/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var body: UILabel!
    
    
    func setupCell(_ data : Onboarding){
        title1.text = data.title1
        title2.text = data.title2
        imageView.image = data.image
        body.text = data.body
    }
}
