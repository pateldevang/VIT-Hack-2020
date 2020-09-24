//
//  LaunchViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 25/09/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    @IBOutlet weak var launchImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.traitCollection.userInterfaceStyle == .dark {
            let launchGif = UIImage.gifImageWithName("gif_dark")
            launchImage.image = launchGif
        } else {
            let launchGif = UIImage.gifImageWithName("gif_light")
            launchImage.image = launchGif
        }
    }
}
