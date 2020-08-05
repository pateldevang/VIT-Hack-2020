//
//  QuestionViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 05/08/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var askButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func askTapped(_ sender: Any) {
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
