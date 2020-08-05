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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staticFAQ.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: faqCellIdentifier) as! FaqCell
        
        let faq = staticFAQ[indexPath.row]
        cell.header.text = faq.question
        cell.body.text = faq.answer
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = staticFAQ[indexPath.row].answer
        let height = extimateFrameForText(text: text ?? "")
        return height + 90
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension FAQViewController {
    private func extimateFrameForText(text: String) -> CGFloat {
        let width = (view.frame.width) - 100
        
        let size = CGSize(width: width, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let height = NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Lato-Regular", size: 14)!], context: nil).height
        
        return height
    }
}
