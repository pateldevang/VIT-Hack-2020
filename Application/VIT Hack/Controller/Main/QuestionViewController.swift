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
    @IBOutlet weak var askTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initialSetup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        askTextView.text = ""
    }
    
    func initialSetup(){
        askButton.bottomShadow()
        cancelButton.outline()
        askTextView.outline()
        cardShadow()
    }
    
    func cardShadow(){
        card.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        card.layer.shadowOffset = CGSize(width: 0, height: 0)
        card.layer.shadowRadius = 24
        card.layer.shadowOpacity = 1
        card.layer.masksToBounds = false
        card.alpha = 1.0
    }
    
    @IBAction func askTapped(_ sender: Any) {
        askQuestion()
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func askQuestion(){
        let text = askTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if !text.isEmpty {
            let question = ["\(Int(Date().timeIntervalSince1970*1000))":text]
            firebaseNetworking.shared.postQuestion(param: question, completion: handleQuestion(success:))
        }
    }
    
    func handleQuestion(success : Bool){
        if success{
            UIView.animate(withDuration: 0.3, animations: {
                self.card.alpha = 0.0
                self.view.endEditing(true)
            }) { _ in
                self.sucessAlert()
            }
        } else {
            authAlert(message: "Please try again!")
        }
    }
    
    func sucessAlert(){
        let alert = UIAlertController(title: "Question Sent ↗️", message: "We will answer your question shortly!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
