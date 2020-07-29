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
        self.setupLayout()
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
    
    fileprivate func setupLayout() {
        let layout = self.collectionView.collectionViewLayout as! AKCarouselFlowLayout
        layout.spacingMode = AKCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
    }
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! AKCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
     //   currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        let centrePoint = CGPoint(x: self.collectionView.frame.size.width/2 + self.collectionView.contentOffset.x/2, y: self.collectionView.frame.size.height/2 + self.collectionView.contentOffset.y/2)
//
//        if let indexPath = self.collectionView.indexPathForItem(at: centrePoint) {
//            self.centercell = self.collectionView.cellForItem(at: indexPath) as? DomainsCell
//            if centercell != nil {
//            centercell.transformCell()
//            }
//        }
//
//        if let cell = self.centercell {
//            let offset = centrePoint.x -  cell.center.x
//
//            if offset < -110 || offset > 110{
//                cell.transformNormal()
//                centercell = nil
//            }
//        }
//    }
    

}

extension DomainsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 272, height: 500)
    }
    
}

