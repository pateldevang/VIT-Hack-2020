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
      //  self.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
    
    func transformCell(){
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.18, y: 1.18)
        }
    }
    
    func transformNormal(){
        UIView.animate(withDuration: 2) {
            self.transform = .identity
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
       // self.transform = CGAffineTransform(scaleX: collectionViewScale, y: collectionViewScale)
    }
}
