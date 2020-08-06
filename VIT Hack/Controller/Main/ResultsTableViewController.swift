//
//  ResultsTableViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 05/08/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

//MARK:- RESULTS TABLE VIEW ( USED UNDER SEARCH CONTROLLER )

//MARK: Cell is same as FAQViewController

class ResultsTableViewController: UITableViewController {
    
    let tableViewCellIdentifier = "faqcell2"
    
    var filteredProducts = [FAQData]()
    
    // MARK: - UITableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as! FaqCell
        
        let data = filteredProducts[indexPath.row]
        
        cell.header.text = data.question
        
        cell.body.text = data.answer
    
        return cell
        
    }
}
