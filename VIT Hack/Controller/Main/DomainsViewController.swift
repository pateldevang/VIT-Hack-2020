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
    
    let domainCellIdentifier = "domaincell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

extension DomainsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return domains.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: domainCellIdentifier, for: indexPath) as! DomainsCell
        let data = domains[indexPath.item]
        cell.setupCell(data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = view.frame.width
        let width = screenWidth * 0.68
        let height = width * 1.8
        return CGSize(width: width, height: height)
    }
    
}

