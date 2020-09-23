//
//  DomainsViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class DomainsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var domains = [DomainData]()
    
    var domainData = DomainData()
    
    let domainCellIdentifier = "domaincell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = ControllerDefaults.tracks() { self.domains = data }
        firebaseNetworking.shared.getDomains(completion: getDomains(success:result:))
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tracksVC = segue.destination as? TracksViewController {
            if let ps = sender as? [String]{
                tracksVC.tracks = ps
                tracksVC.domain = self.domainData
            }
        }
    }
}

extension DomainsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return domains.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: domainCellIdentifier, for: indexPath) as! DomainsCell
        let data = domains[indexPath.item]
        cell.setupCell(data)
        cell.showmore = showMore(_:)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height * 0.85
        let width = collectionView.frame.width * 0.67
        return CGSize(width: width, height: height)
    }
    
    func showMore(_ path : Int){
        let ps = self.domains[path].problemStatements
        self.domainData = self.domains[path]
        performSegue(withIdentifier: "tracks", sender: ps)
    }
}

