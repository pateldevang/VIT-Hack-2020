//
//  AboutUsViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    /// Collectionview to present `AboutUs` data.
    @IBOutlet weak var collectionview: UICollectionView!
    
    /// `datasource` of collectionview
    var aboutUs = [
    AboutUsData(name: "Aaryan Kothari", role: "iOS Developer", image: "speaker1", socialHandles: [.github,.LinkedIn,.instagram]),
    AboutUsData(name: "Devang Patel", role: "iOS Developer", image: "speaker3", socialHandles: [.github,.LinkedIn,.mail]),
    AboutUsData(name: "Garima Bothra", role: "iOS Developer", image: "speaker3", socialHandles: [.github,.LinkedIn,.twitter]),
    AboutUsData(name: "Rohan Arora", role: "UX/UI Designer", image: "speaker1", socialHandles: [.github,.LinkedIn,.instagram]),
    AboutUsData(name: "Hemanth Krishna", role: "Android Developer", image: "speaker3", socialHandles: [.github,.LinkedIn,.instagram]),
    AboutUsData(name: "Vibhor Chinda", role: "Android Developer", image: "speaker1", socialHandles: [.github,.LinkedIn,.instagram])]
    
    ///Cell Identifier of AboutUs Cell
    let aboutusIdentifier = "aboutuscell"
}

//MARK:- CollectionView Datasource + Delegate Methods
extension AboutUsViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aboutUs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = aboutUs[indexPath.row]
        
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: aboutusIdentifier, for: indexPath) as! AboutUsCell
        
        cell.name.text = data.name
        cell.profilePhoto.image = UIImage(named: data.image)
        cell.designation.text = data.role
        cell.setupCell(data.socialHandles)
        return cell
    }
}


//MARK:- CollectionView FlowLayout Methods
extension AboutUsViewController : UICollectionViewDelegateFlowLayout{
    
    /// Dynamic cell size `According to screen size!`
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 80
        let cellWidth = width/2
        let cellHeight = cellWidth * 4/3
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}

