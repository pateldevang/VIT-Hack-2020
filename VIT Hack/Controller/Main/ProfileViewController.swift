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
    @IBOutlet weak var profileTabel: UITableView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var initials: UILabel!
    
    var profileValues = ["Your Name":"","Email Address":"Your Institute","Registration Number":""]
    
    var tableHeight : CGFloat = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        tableHeight = profileTabel.frame.height
        self.profileTabel.reloadData()
    }
    
    ///Fetch data  from `Userdefaults`
    func loadData(){
        profileValues["Your Name"] = Defaults.name()
        profileValues["Email Address"] = getEmail()
        profileValues["Your Institute"] = Defaults.institute()
        profileValues["Registration Number"] = Defaults.registration()
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

extension ProfileViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTabel.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.title.text = Array(profileValues.keys)[indexPath.row]
        cell.value.text = Array(profileValues.values)[indexPath.row]
        
        return cell
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return tableHeight/4
      }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension String {
    var wordList: [String] {
        let separation = CharacterSet.alphanumerics.inverted
        return self.isEmpty ? [] : components(separatedBy: separation).filter { !$0.isEmpty }
    }
}
