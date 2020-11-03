//
//  Progressbar.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 18/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import UIKit


//MARK: ------ CUSTOM PROGRESS BAR --------


final class Progressbar: CAShapeLayer, CAAnimationDelegate {
    
    var start : CGFloat = 0.33
    var end : CGFloat = 0.66
    
    var animationDuration: TimeInterval = 0
    
    var progress = CAShapeLayer()
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(for view: UIView, duration: TimeInterval, startValue start : CGFloat, endValue end : CGFloat ) {
        super.init()
        self.animationDuration = duration
        self.start = start
        self.end = end
        
        DispatchQueue.main.async {
            self.showProgress(view: view)
        }
    }
    
    func showProgress(view: UIView) {
        let width  : CGFloat = view.frame.width
        let height  : CGFloat = view.frame.height
        let heightFactor = height/2

        let barPath = UIBezierPath()
        barPath.move(to: CGPoint(x: heightFactor, y: heightFactor))
        barPath.addLine(to: CGPoint(x:(end * width)-(heightFactor), y: heightFactor))
        
        progress.path = barPath.cgPath
        progress.fillColor = UIColor.clear.cgColor
        progress.lineWidth = height
        progress.strokeEnd =  start > 0.5 ? (1-start) : (start)
        progress.lineCap = .round
        progress.strokeColor = UIColor(named: "progress")?.cgColor
        self.insertSublayer(progress, above: self)
        
        let strokeEnd = animate(duration: animationDuration)
        self.progress.add(strokeEnd, forKey: "strokeEnd")
        
        view.layer.cornerRadius = heightFactor
    }
    
    func animate(duration: TimeInterval) -> CABasicAnimation {
        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.duration = duration
        strokeEnd.toValue = 1.0
        strokeEnd.isRemovedOnCompletion = false
        strokeEnd.fillMode = .forwards
        return strokeEnd
    }
}


