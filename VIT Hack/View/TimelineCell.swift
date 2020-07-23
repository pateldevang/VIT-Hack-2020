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
        }
        addShadow(watchNowButton)
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
    
    func addShadow(_ view : UIView){


        let shadowPath0 = UIBezierPath(roundedRect: view.bounds, cornerRadius: 4)
        let layer0 = CALayer()
        
        layer0.cornerRadius = 15.0
        layer0.borderWidth = 0.0
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.shadowRadius = 4
        layer0.shadowOpacity = 1
        layer0.masksToBounds = false
        
        
        layer0.shadowPath = shadowPath0.cgPath
        view.layer.addSublayer(layer0)
        
        /// Background Shadow

    }
}
