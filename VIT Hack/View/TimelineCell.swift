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
    @IBOutlet weak var watchNowButton: UIButton!
    @IBOutlet weak var tick: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tick.isHidden = true
    }
    
    func setupCell(_ timeline : TimelineData) {
        watchNowButton.isHidden = timeline.link == nil
        titleLabel.text = timeline.title
        bodyTextView.text = timeline.subtitle
        
        if let sTime = timeline.startUnix {
        timeLabel.text = sTime.timeStringConverter
        }
        
        if let eTime = timeline.endUnix, eTime < Date().timeIntervalSince1970 {
            tick.isHidden = false
        }
    }
    
    @IBAction func watchNow(_ sender: Any) {
        
    }
}
