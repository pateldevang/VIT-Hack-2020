//
//  HomeViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 14/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    // Unhashed nonce.
    var currentNonce: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        appleButton.bottomShadow()
        googleButton.bottomShadow()
        emailButton.bottomShadow()
    }
}
