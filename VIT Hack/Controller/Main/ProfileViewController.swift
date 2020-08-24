//
//  ProfileViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    //OUTLETS
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var initials: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var institute: UILabel!
    @IBOutlet weak var registration: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    ///Fetch data  from `Userdefaults`
    func loadData(){
        name.text = Defaults.name()
        email.text = getEmail()
        institute.text = Defaults.institute()
        registration.text = Defaults.registration()
        header.text = "What’s up " + getFirstName()
        initials.text = getInitials()
    }
    
    func getFirstName()->String{
        let name = Defaults.name().wordList
        return name.first ?? ""
    }
    
    func getInitials()->String{
        let name = Defaults.name().wordList
        let fName = name.first?.first ?? Character(" ")
        let lname = name.last?.first ??  Character(" ")
        return (name.count == 1) ? String(fName) : String(fName) + " " + String(lname)
    }
    
    @IBAction func logoutClicked(_ sender: UIButton) {
        signOut()
    }
}

extension String {
    var wordList: [String] {
        let separation = CharacterSet.alphanumerics.inverted
        return self.isEmpty ? [] : components(separatedBy: separation).filter { !$0.isEmpty }
    }
}
