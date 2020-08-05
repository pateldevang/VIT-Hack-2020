//
//  FAQViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 05/08/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class FAQViewController: UITableViewController {
    
    var staticFAQ : [FAQData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchStaticFAQ(){
        firebaseNetworking.shared.getFAQ { (success, response) in
            if success {
                self.staticFAQ = response
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return 0
    }
}
