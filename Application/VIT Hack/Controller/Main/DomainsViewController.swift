//
//  DomainsViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class DomainsViewController: UIViewController {
    
    /// collectionView to display list of `Domains`
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// `Datasource` for collectionView
    var domains = [DomainData]()
    
    /// Last selected Domain
    var domainData = DomainData()
    
    /// `CellID` for collectionViewCell
    let domainCellIdentifier = "domaincell"
    
    
    //MARK -- APP LIFECYCLE METHODS --
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = ControllerDefaults.tracks() { self.domains = data } /// load local data
        firebaseNetworking.shared.getDomains(completion: getDomains(success:result:)) /// load data from firebase
    }
    
    
    func getDomains(success:Bool,result:[DomainData]){
        if success{ self.domains = result }
        DispatchQueue.main.async { self.collectionView.reloadData() }
    }
    

    fileprivate var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! AKCarouselFlowLayout
        var pageSize = layout.itemSize
        pageSize.width += layout.minimumLineSpacing
        return pageSize
    }
    
    // -- NAVIGATION PREP --
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tracksVC = segue.destination as? TracksViewController {
            if let ps = sender as? [psModel]{
                tracksVC.tracks = ps
                tracksVC.domain = self.domainData
            }
        }
    }
    
}

//MARK:- COLLECTIONVIEW DELEGATE + DATASOURCE + DELEGATEFLOWLAYOUT METHODS
extension DomainsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return domains.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: domainCellIdentifier, for: indexPath) as! DomainsCell
        let data = domains[indexPath.item]
        cell.setupCell(data)
        cell.showMore.tag = indexPath.item
        cell.showMore.addTarget(self, action: #selector(showMore(sender:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height * 0.85
        let width = collectionView.frame.width * 0.67
        return CGSize(width: width, height: height)
    }
    
    @objc
    func showMore(sender: UIButton){
        let ps = self.domains[sender.tag].finalData
        self.domainData = self.domains[sender.tag]
        performSegue(withIdentifier: "tracks", sender: ps)
    }
}

