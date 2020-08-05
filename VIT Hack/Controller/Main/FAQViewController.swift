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
    
    let faqCellIdentifier = "faqcell"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStaticFAQ()
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        performSegue(withIdentifier: "ask", sender: nil)
    }
    
    func fetchStaticFAQ(){
        firebaseNetworking.shared.getFAQ { (success, response) in
            if success {
                self.staticFAQ = response
                print(response)
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
        return staticFAQ.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: faqCellIdentifier) as! TracksCell
        let faq = staticFAQ[indexPath.row]
        cell.header.text = faq.question
        cell.body.text = faq.answer
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
