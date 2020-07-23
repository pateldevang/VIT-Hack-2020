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
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tick.isHidden = true
    }
    
    func setupCell(_ timeline : TimelineData) {
        if timeline.link == ""{
            watchNowButton.isHidden = true
            bottom.priority = UILayoutPriority(rawValue: 1000)
        } else {
            watchNowButton.isHidden = false
            bottom.priority = UILayoutPriority(rawValue: 500)
        }
        addShadow()
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
    
    func addShadow(){
        watchNowButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        watchNowButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        watchNowButton.layer.shadowOpacity = 1.0
        watchNowButton.layer.shadowRadius = 4.0
        watchNowButton.layer.masksToBounds = false
        watchNowButton.layer.cornerRadius = 4.0
    }
}
