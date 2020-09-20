//
//  AboutUsViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import SafariServices

@available(iOS 13.0, *)
class AboutUsViewController: UIViewController {
    
    /// Collectionview to present `AboutUs` data.
    @IBOutlet weak var collectionview: UICollectionView!
    

    
    /// `datasource` of collectionview
    var aboutUs = [
        AboutUsData(name: "Aaryan Kothari", role: "iOS Developer", image: "speaker1", socialHandles: [.github,.LinkedIn,.instagram], socailUrls: ["https://github.com/aaryankotharii","https://www.linkedin.com/in/aaryankotharii/"]),
    AboutUsData(name: "Devang Patel", role: "iOS Developer", image: "speaker3", socialHandles: [.github,.LinkedIn,.mail]),
    AboutUsData(name: "Garima Bothra", role: "iOS Developer", image: "speaker3", socialHandles: [.github,.LinkedIn,.twitter]),
    AboutUsData(name: "Rohan Arora", role: "UX/UI Designer", image: "speaker1", socialHandles: [.github,.LinkedIn,.instagram]),
    AboutUsData(name: "Hemanth Krishna", role: "Android Developer", image: "speaker3", socialHandles: [.github,.LinkedIn,.instagram]),
    AboutUsData(name: "Vibhor Chinda", role: "Android Developer", image: "speaker1", socialHandles: [.github,.LinkedIn,.instagram])]
    
    ///Cell Identifier of AboutUs Cell
    let aboutusIdentifier = "aboutuscell"
}

//MARK:- CollectionView Datasource + Delegate Methods
@available(iOS 13.0, *)
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
    
    @available(iOS 13.0, *)
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
            return self.makeContextMenu(for: indexPath.row)
        })
    }
    
    
    @available(iOS 13.0, *)
    func makeContextMenu(for index:Int) -> UIMenu {
        var actions = [UIAction]()
        let person = aboutUs[index]
        for item in person.socialHandles {
            let action = UIAction(title: item.rawValue, image: UIImage(named: item.rawValue), identifier: nil, discoverabilityTitle: nil) { _ in
                let social = person.socialHandles.firstIndex(of: item)
                self.didSelectItemAtIndex(person: person, social: social!)
            }
            actions.append(action)
        }
        let cancel = UIAction(title: "Cancel", attributes: .destructive) { _ in}
        actions.append(cancel)
        return UIMenu(title: "", children: actions)
    }
    
    func didSelectItemAtIndex(person index : AboutUsData,social id : Int){
        let url = index.socailUrls[id]
        openWebsite(url)
    }
}


//MARK:- CollectionView FlowLayout Methods
@available(iOS 13.0, *)
extension AboutUsViewController : UICollectionViewDelegateFlowLayout{
    
    /// Dynamic cell size `According to screen size!`
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 80
        let cellWidth = width/2
        let cellHeight = cellWidth * 4/3
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
