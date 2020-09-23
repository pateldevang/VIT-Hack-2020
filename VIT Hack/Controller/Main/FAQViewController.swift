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
    
    /// cell identifier for `faqCell`
    let faqCellIdentifier = "faqcell"
    
    /// Search controller to help us with filtering items in the table view.
    var searchController: UISearchController!
    
    var questionViewController : QuestionViewController!
    
    /// `Search` results table view.
    private var resultsTableController: ResultsTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupQuestionController()
        if let faq = ControllerDefaults.FAQ() { self.staticFAQ = faq }
        firebaseNetworking.shared.getFAQ(completion: handleFAQ(success:response:))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.searchController = searchController
    }
    
    fileprivate func setupSearchController() {
        resultsTableController =
            self.storyboard?.instantiateViewController(withIdentifier: "ResultsTableController") as? ResultsTableViewController
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
    }
    
    fileprivate func setupQuestionController() {
        if #available(iOS 13.0, *) {
            self.questionViewController = mainStoryboard.instantiateViewController(identifier: "QuestionViewController")
        } else {
            self.questionViewController = mainStoryboard.instantiateViewController(withIdentifier: "QuestionViewController") as? QuestionViewController
        }
        questionViewController.modalPresentationStyle = .overFullScreen
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        self.present(questionViewController, animated: true, completion: nil)
    }
    
    func handleFAQ(success:Bool,response:[FAQData]){
        if success {
            self.staticFAQ = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
        let text = staticFAQ[indexPath.row].answer ?? ""
        let question = staticFAQ[indexPath.row].question ?? ""
        let height = extimateFrameForText(text: text,question: question)
        return height + 60
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}


extension FAQViewController {
    private func extimateFrameForText(text: String, question : String) -> CGFloat {
        let width = (view.frame.width) - 80
        
        let size = CGSize(width: width, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let height = NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Lato-Regular", size: 16)!], context: nil).height
        
        let qHeight = NSString(string: question).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Lato-Bold", size: 18)!], context: nil).height
        
        return height + qHeight
    }
}

//MARK:- SearchController Delegate Methods
extension FAQViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        updateSearchResults(for: searchController.searchBar)
    }
    
    func updateSearchResults(for searchbar: UISearchBar) {
        if let text = searchbar.text{
            if text.count > 0 {
                let filterData = staticFAQ.filter { ($0.question?.lowercased().contains(text.lowercased()) ?? false) || ($0.answer?.lowercased().contains(text.lowercased()) ?? false)}
                if let resultsController = searchController.searchResultsController as? ResultsTableViewController {
                    resultsController.filteredProducts = filterData
                    DispatchQueue.main.async {
                        resultsController.tableView.reloadData()
                    }
                }
            }
        }
    }
}
