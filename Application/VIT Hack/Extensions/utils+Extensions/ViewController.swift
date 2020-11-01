//
//  ViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 29/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit


extension UIViewController {
    //MARK: Go to TabbarViewController
    func gototabbar(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            let vc = storyboard.instantiateViewController(identifier: "tabbar") as! UITabBarController
            self.present(vc, animated: true)
        } else {
            let vc = storyboard.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
            self.present(vc, animated: true)
        }
    }
    
    //MARK: download all data upon start for persistance
    func downloadData(){
        firebaseNetworking.shared.getTimeline { (_, _) in }
        firebaseNetworking.shared.getDomains { (_, _) in }
        firebaseNetworking.shared.getFAQ { (_, _) in }
        firebaseNetworking.shared.getSponsor { (_, _) in }
        firebaseNetworking.shared.getSpeaker { (_, _) in }
        firebaseNetworking.shared.getSponsor(isCollaborator: true) { (_, _) in }
    }
    
    //MARK:- Keyboard Toolbar Setup.
    func addInputAccessoryForTextFields(textFields: [UITextField]) {
        for (index, textField) in textFields.enumerated() {
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            
            var items = [UIBarButtonItem]()
            let previousButton = UIBarButtonItem(title: "Previous", style: .plain, target: nil, action: nil)
            previousButton.width = 30
            if textField == textFields.first {
                previousButton.isEnabled = false
            } else {
                previousButton.target = textFields[index - 1]
                previousButton.action = #selector(UITextField.becomeFirstResponder)
            }
            
            var nextButton = UIBarButtonItem(title: "Next", style: .plain, target: nil, action: nil)
            nextButton.width = 30
            if textField == textFields.last {
                nextButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing))
            } else {
                nextButton.target = textFields[index + 1]
                nextButton.action = #selector(UITextField.becomeFirstResponder)
            }
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            items.append(contentsOf: [previousButton,spacer ,nextButton])
            
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
    }
    
    func addDoneButtonToolbar(textField: UITextField) {
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([spacer ,doneButton], animated: false)
        textField.inputAccessoryView = toolbar
    }
}
