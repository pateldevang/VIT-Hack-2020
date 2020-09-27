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
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileBack: UIView!
    
    //VARIABLES
    var profileTitles = ["Your Name","Email Address","Your Institute","Registration Number"]
    var profileValues = ["","","",""]
    var tableHeight : CGFloat = 0.0
    
    // CONSTANTS
    let profileIdentifier = "ProfileCell"
    let privacyPolicy = "https://gist.githubusercontent.com/aaryankotharii/02c59dee50c694a7c180a976f5543287/raw/8ea0f530f9e699b25aaaed4eb90d3e6b5f795bbd/gistfile1.txt"
    
    let socials = ["https://www.linkedin.com/company/hackvit/","https://www.instagram.com/vithack2020/","https://twitter.com/VITHack2020/","https://www.facebook.com/vithack19/"]
    
    // APP-CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        //setupPrivacyLabel()
    }
    
    override func viewDidLayoutSubviews() {
        tableHeight = profileTabel.frame.height
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileBack.layer.cornerRadius = profileBack.frame.width/2
        self.profileTabel.reloadData()
    }
    
    // PRIVACY POLICY TAPPED
    @IBAction func privacyTapped(_ sender: Any) {
        openWebsite(privacyPolicy)
    }
    
    @IBAction func socialTappes(_ sender: UIButton) {
        openWebsite(socials[sender.tag])
    }
    
    func setupPrivacyLabel(){
        let attributesForUnderLine: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let textToSet = "Privacy Policy"
        let rangeOfUnderLine = (textToSet as NSString).range(of: textToSet)
        
        let attributedText = NSMutableAttributedString(string: textToSet)
        attributedText.addAttributes(attributesForUnderLine, range: rangeOfUnderLine)
        //privacyPolicyLabel.attributedText = attributedText
    }
    
    ///Fetch data  from `Userdefaults`
    func loadData(){
        profileValues[0] = Defaults.name()
        profileValues[1] = getEmail()
        profileValues[2] = Defaults.institute()
        profileValues[3] = Defaults.registration()
        header.text = "What’s up " + getFirstName()
        initials.text = getInitials()
    }
    
    /// GET `First Name` of user
    func getFirstName()->String{
        let name = Defaults.name().wordList
        return name.first ?? ""
    }
    
    /// GET `Initials` of user
    func getInitials()->String{
        let name = Defaults.name().wordList
        let fName = name.first?.first ?? Character(" ")
        let lname = name.last?.first ??  Character(" ")
        return (name.count == 1) ? String(fName) : String(fName) + " " + String(lname)
    }
    
    // LOGOUT
    @IBAction func logoutClicked(_ sender: UIButton) {
        signOut()
    }
}

//MARK - PROFILE TABLEVIEW DELEGATE + DATASOURCE METHODS
extension ProfileViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTabel.dequeueReusableCell(withIdentifier: profileIdentifier, for: indexPath) as! ProfileCell
        cell.setupCell(profileTitles,profileValues, indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableHeight/4 /// FOUR EQUAL ROWS
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

