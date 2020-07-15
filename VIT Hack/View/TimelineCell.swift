//
//  TimelineCell.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(_ timeline : TimelineData) {
        titleLabel.text = timeline.title
        bodyTextView.text = timeline.subtitle
        
        timeLabel.text = timeline.startUnix!.timeStringConverter
        
    }
    
    
}
