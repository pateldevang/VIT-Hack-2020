//
//  SpeakersCell.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 18/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

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
        image.image = #imageLiteral(resourceName: "speaker1") //TODO
    }
    
}
