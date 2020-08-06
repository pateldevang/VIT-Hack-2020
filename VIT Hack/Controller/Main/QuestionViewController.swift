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
    }

    
    @IBAction func askTapped(_ sender: Any) {
        askQuestion()
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func askQuestion(){
        if !askTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let question = ["\(Int(Date().timeIntervalSince1970*1000))":askTextView.text!]
            print(question)
            firebaseNetworking.shared.postQuestion(param: question, completion: handleQuestion(success:))
        }
    }
    
    func handleQuestion(success : Bool){
        if success{
            self.dismiss(animated: true, completion: nil)
        }
    }
    

}
