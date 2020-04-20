//
//  CompanyVC.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/04/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class CompanyVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var companyCollectionview: UICollectionView!
    
    //MARK:- Variables
    var selectedIndexPath: IndexPath?
    var selectedComany = String()
    var companies = [CompanyData](){
        didSet{
            DispatchQueue.main.async {
                self.companyCollectionview.reloadData()
            }
        }
    }
    
    
    //MARK:- This Data is Sample and for testing Purposes
    var sampleCompanies : [CompanyData] = [CompanyData(description: "Very Good Company", logoUrl: "fb_sample", name: "Facebook", pageUrl: "pageUrl", venue: "SJT"),CompanyData(description: "Very Good Company", logoUrl: "honeywell_sample", name: "Honeywell", pageUrl: "pageUrl", venue: "TT"),CompanyData(description: "Very Good Company", logoUrl: "starbucks_sample", name: "Starbucks", pageUrl: "pageUrl", venue: "SJT"),CompanyData(description: "Very Good Company", logoUrl: "snapchat_sample", name: "Snapchat", pageUrl: "pageUrl", venue: "GDN")]
    
    var sampleColors : [UIColor] = [#colorLiteral(red: 0.2588235294, green: 0.4039215686, blue: 0.6980392157, alpha: 1),#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.02745098039, green: 0.4392156863, blue: 0.2588235294, alpha: 1),#colorLiteral(red: 1, green: 0.9843137255, blue: 0, alpha: 1),]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Calling getCompanyDetails
        firebaseNetworking.shared.getCompanyDetails { (result, data) in
            if result { self.companies = data }
        }
    }
    
    //MARK:- next button action after selecting company
    @IBAction func NextClicked(_ sender: UIButton) {
        firebaseNetworking.shared.updateCompanyName(companyName: selectedComany) { (status) in
            print(status)
            if status == true {
                self.performSegue(withIdentifier: "goToTabBar", sender: self)
                UserDefaults.standard.set(true, forKey: "login")
            }
            else {
                self.authAlert(titlepass: "Error", message: "Please try again!")
            }
        }
    }
}



//MARK:- CollectionView Delegate Methdos
extension CompanyVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //MARK: - numberOfItemsInSection section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //MARK:- unhighlight is not using sample Data
        // return companies.count
        return sampleCompanies.count
    }
    
    //MARK: - cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = companyCollectionview.dequeueReusableCell(withReuseIdentifier: "companycell", for: indexPath) as! CompanyCollectionViewCell
        
        //MARK:- unhighlight is not using sample Data
        //let company = companies[indexPath.item]
        
        let company = sampleCompanies[indexPath.row]
        let color = sampleColors[indexPath.row]
        
        setupCell(cell: cell, company: company, color: color)
        return cell
    }
    
    
    //MARK:- Cell UI Setup
    func setupCell(cell: CompanyCollectionViewCell, company : CompanyData, color: UIColor){
        if let name = company.name { cell.nameLabel.text = name }
        if let logoUrl = company.logoUrl { cell.logoImageView.image = UIImage(named: logoUrl)}
        cell.bgView.layer.cornerRadius = 8
        cell.bgView.layer.borderWidth = 2
        cell.bgView.layer.borderColor = color.cgColor
        cell.bgView.layer.shadowPath = UIBezierPath(roundedRect: (cell.bgView.bounds), cornerRadius: 8).cgPath
        cell.bgView.layer.shadowColor = color.cgColor
        cell.bgView.layer.shadowOpacity = 0.5
        cell.bgView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.bgView.layer.shadowRadius = 1
        cell.bgView.layer.masksToBounds = false
        cell.bgView.backgroundColor = .white
    }
    
    
    //MARK: - didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //MARK:- unhighlight is not using sample Data
        // let company = companies[indexPath.item]
        let company = sampleCompanies[indexPath.item]
        
        //MARK:- assigning User company
        let companyName = company.name ?? "No Name?"
        print("User has selected \(companyName)")
        self.selectedComany = companyName
        self.navItem.title = companyName
        
        if let cell = companyCollectionview.cellForItem(at: indexPath) as? CompanyCollectionViewCell {
            cell.bgView.backgroundColor = #colorLiteral(red: 0.7921568627, green: 1, blue: 0.8352941176, alpha: 1)
        }
    }
    
    //MARK:- didDeselectItemAt
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = companyCollectionview.cellForItem(at: indexPath) as? CompanyCollectionViewCell {
            cell.bgView.backgroundColor = .white
        }
    }
    
    //MARK:- Static cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 182, height: 207)
    }
    
    
    //MARK:- Will review later ( function for dynamic height )
    /*  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     let Screenwidth = UIScreen.main.bounds.width
     let width = (Screenwidth-42)/2
     let aspectRatio : CGFloat = 1.0810810811
     let height = width * aspectRatio
     return CGSize(width: width, height: height)
     }
     */
}
