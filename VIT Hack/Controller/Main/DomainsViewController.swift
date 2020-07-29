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
    
    
    var domains = [DomainData(title: "Machine Learning", body: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis ", Image: #imageLiteral(resourceName: "carbon_watson-machine-learning"), color: #colorLiteral(red: 0.6318229437, green: 0.8350182176, blue: 1, alpha: 1), problemStatements: []),
                   DomainData(title: "Cyber Security", body: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis ", Image: #imageLiteral(resourceName: "carbon_watson-machine-learning"), color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), problemStatements: []),
                   DomainData(title: "App Development", body: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis ", Image: #imageLiteral(resourceName: "carbon_watson-machine-learning"), color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), problemStatements: []),
                   DomainData(title: "Web Development", body: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis ", Image: #imageLiteral(resourceName: "carbon_watson-machine-learning"), color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), problemStatements: [])]
    
    let domainCellIdentifier = "domaincell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
     var centercell : DomainsCell!
    
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! AKCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    

    
    
}

extension DomainsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return domains.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: domainCellIdentifier, for: indexPath) as! DomainsCell
        let data = domains[indexPath.item]
        cell.setupCell(data)
        return cell
    }
    

    

}

extension DomainsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = view.frame.width
        let width = screenWidth * 0.64
        let height = width * 1.72
        return CGSize(width: width, height: height)
    }
    
}

