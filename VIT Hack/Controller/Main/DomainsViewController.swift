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
    
    var domains = [DomainData(title: "Machine Learning", body: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis ", Image: #imageLiteral(resourceName: "carbon_watson-machine-learning"), color: #colorLiteral(red: 0.6318229437, green: 0.8350182176, blue: 1, alpha: 1), problemStatements: [])]
    
    let domainCellIdentifier = "domaincell"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
