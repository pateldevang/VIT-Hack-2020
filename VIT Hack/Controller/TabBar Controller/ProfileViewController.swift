//
//  ProfileViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var initials: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var institute: UILabel!
    @IBOutlet weak var registration: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadData(){
       
    }
    
    
    
    @IBAction func logoutClicked(_ sender: UIButton) {
    }
}
