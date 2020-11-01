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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = filteredProducts[indexPath.row].answer ?? ""
        let question = filteredProducts[indexPath.row].question ?? ""
        let height = extimateFrameForText(text: text,question: question)
        return height + 60
    }
    
    private func extimateFrameForText(text: String, question : String) -> CGFloat {
        let width = (view.frame.width) - 80
        
        let size = CGSize(width: width, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let height = NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Lato-Regular", size: 16)!], context: nil).height
        
        let qHeight = NSString(string: question).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Lato-Bold", size: 18)!], context: nil).height
        
        return height + qHeight
    }
    
}
