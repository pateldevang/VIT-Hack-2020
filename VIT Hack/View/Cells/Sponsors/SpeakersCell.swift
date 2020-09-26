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
    
    var pulsatingLayer : CAShapeLayer!
    
    func setupCell(_ data : SpeakersData){
        name.text = data.name
        designation.text = data.designation
        company.text = data.company
        initialSetup(data.startUnix, data.endUnix)
        join.layer.cornerRadius = 4
        setImage(data)
    }
    
    func setImage(_ data : SpeakersData){
        image.kf.indicatorType = .activity
        
        let processor = RoundCornerImageProcessor(radius: .heightFraction(0.5))
                
        if let imageUrl =  data.imageUrl ,let url = URL(string: imageUrl){
            image.kf.setImage(
                with: url,
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage,
                    .processor(processor)
            ])
        }
        
        image.layer.cornerRadius = image.frame.width/2
    }
    
    func initialSetup(_ startTime : Double?, _ endTime : Double?){
        guard let sTime = startTime else { return }
        guard let eTime = endTime else { return }
        if Date(timeIntervalSince1970: sTime) < Date() && Date(timeIntervalSince1970: eTime) > Date() {
            setLayer()
            join.setTitle("Join Now", for: .normal)
        } else {
            join.setTitle("Watch Now", for: .normal)
            removeSubLayer()
        }
    }
    
    func setLayer(){
        removeSubLayer()
        //Pulsating Layer + animate pulsating layer
        pulsatingLayer = CAShapeLayer()
        let pathForPulsatingLayer = UIBezierPath(arcCenter: .zero, radius: 40, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi , clockwise: true)
        pulsatingLayer.path = pathForPulsatingLayer.cgPath
        pulsatingLayer.strokeColor=UIColor.clear.cgColor
        pulsatingLayer.lineWidth=15
        pulsatingLayer.lineCap=CAShapeLayerLineCap.round
        pulsatingLayer.fillColor = #colorLiteral(red: 0, green: 0.4431372549, blue: 0.8039215686, alpha: 0.4)
        pulsatingLayer.position = image.center
        contentView.layer.insertSublayer(pulsatingLayer, below: image.layer)
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration=1
        animation.timingFunction=CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeOut)
        animation.autoreverses=true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation, forKey:"abcd")
    }
    
    func removeSubLayer(){
        if let sublayers = contentView.layer.sublayers{
            for sublayer in sublayers{
                if sublayer == pulsatingLayer{
                    sublayer.removeFromSuperlayer()
                }
            }
        }
    }
    
}
