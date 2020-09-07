//
//  statusBarView.swift
//  VIT Hack
//
//  Created by Devang Patel on 02/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import Foundation


open class StatusBarMessage: UIView {
    
    
    var duration:TimeInterval?
    
    var text:String?{
        get {
            return textLabel.text
        }
        set {
            textLabel.text = newValue
        }
    }
    

    
    var style:StatusBarMessageStyle?
    
    static let height:CGFloat = UIApplication.shared.statusBarFrame.size.height + 40
    static let currentWindow:UIWindow! = UIApplication.shared.windows.last
    
    lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 18)
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    func colorWithStyle(style:StatusBarMessageStyle) -> UIColor {
        switch style {
        case .success:
            return #colorLiteral(red: 0.2941176471, green: 0.7098039216, blue: 0.262745098, alpha: 1)
        case .error:
            return #colorLiteral(red: 1, green: 0.3575092515, blue: 0.3653251075, alpha: 1)
        }
        
    }

    
    @discardableResult
    public static func show(with text:String, color: UIColor, duration:TimeInterval! = 2.0) -> StatusBarMessage{
        UIApplication.shared.keyWindow?.windowLevel = UIWindow.Level.statusBar
        let messageVIew = StatusBarMessage(text, color: color, duration: duration)
        messageVIew.frame = originFrame()
        currentWindow.addSubview(messageVIew)
        currentWindow.bringSubviewToFront(messageVIew)
        
        UIView.animate(withDuration: 0.2, animations: {
            messageVIew.frame = animateFrame()
        }) { (finish) in
            if finish{
                DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute:{
                    UIView.animate(withDuration: 0.2, animations: {
                        messageVIew.frame = originFrame()
                        statusBarHidden = true
                        UIApplication.shared.keyWindow?.windowLevel = UIWindow.Level.normal
                    })
                })
            }
        }
        return messageVIew
    }
    
    
    static func originFrame() -> CGRect {
        return CGRect.init(x: 0, y: -height, width: currentWindow.bounds.size.width, height: height)
    }
    
    static func animateFrame() -> CGRect {
        return CGRect.init(x: 0, y: 0, width: currentWindow.bounds.size.width, height: height)
    }
    
    convenience init(_ text:String, color:UIColor , duration:TimeInterval) {
        self.init(frame: CGRect.zero)
        self.text = text
        self.duration = duration
        self.backgroundColor = color
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLabel)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = CGRect(x: 0, y: bounds.size.height - 30, width: bounds.size.width, height: 30)
    }
    
}

var statusBarHidden = true {
  didSet(newValue) {
      }
}
