//
//  SpeakersViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class SpeakersViewController: UIViewController {
    
    let speakerIdentifier = "speakercell"
    let collaboratorIdentifier = "Collaboratorcell"
    let sponsorIdentifier = "sponsorcell"
    
    let collaboratorData = [#imageLiteral(resourceName: "Rectangle 30"),#imageLiteral(resourceName: "Rectangle 31"),#imageLiteral(resourceName: "Rectangle 28"),#imageLiteral(resourceName: "Rectangle 30"),#imageLiteral(resourceName: "Rectangle 31"),#imageLiteral(resourceName: "Rectangle 28")]
    let sponsorData = [#imageLiteral(resourceName: "Rectangle 32"),#imageLiteral(resourceName: "Rectangle 34"),#imageLiteral(resourceName: "Rectangle 33"),#imageLiteral(resourceName: "Rectangle 32"),#imageLiteral(resourceName: "Rectangle 34"),#imageLiteral(resourceName: "Rectangle 33")]
    let speakerData = [#imageLiteral(resourceName: "speaker1"),#imageLiteral(resourceName: "speaker2"),#imageLiteral(resourceName: "speaker3"),#imageLiteral(resourceName: "speaker1"),#imageLiteral(resourceName: "speaker2"),#imageLiteral(resourceName: "speaker3")]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}

extension SpeakersViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collection(rawValue: collectionView.tag) {
        case .speakers:
            return sponsorData.count
        case .collaborators:
            return collaboratorData.count
        case .sponsors:
            return sponsorData.count
        case .none:
            print("NOT POSSIBLE")
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellToReturn = UICollectionViewCell()
        if collectionView.tag == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: speakerIdentifier, for: indexPath) as! SpeakersCell
            let speaker = speakerData[indexPath.item]
            cell.image.image = speaker
            cellToReturn = cell
        } else if collectionView.tag == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collaboratorIdentifier, for: indexPath) as! CollaboratorsCell
            let collaborator = collaboratorData[indexPath.item]
            cell.image.image = collaborator
            cellToReturn = cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sponsorIdentifier, for: indexPath) as! SponsorsCell
            let sponsor = sponsorData[indexPath.item]
            cell.image.image = sponsor
            cellToReturn = cell
        }
        return cellToReturn
    }
}

extension SpeakersViewController : UICollectionViewDelegate {
    
}
enum collection : Int {
    case speakers = 0
    case collaborators = 1
    case sponsors = 2
}

