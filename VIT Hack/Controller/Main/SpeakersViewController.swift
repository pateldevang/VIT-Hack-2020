//
//  SpeakersViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class SpeakersViewController: UIViewController {
    
    
    @IBOutlet weak var speakerCollectionView: UICollectionView!
    @IBOutlet weak var collaboratorCollectionView: UICollectionView!
    @IBOutlet weak var sponsorsCollectionView: UICollectionView!
    
    
    
    let speakerIdentifier = "speakercell"
    let collaboratorIdentifier = "Collaboratorcell"
    let sponsorIdentifier = "sponsorcell"
    
    var collaboratorData : [SponsorData] = []
    var sponsorData  : [SponsorData] = []
    var speakerData : [SpeakersData] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSpeakers()
        getSponsors()
        getCollaborators()
    }
    
    func getSpeakers(){
        firebaseNetworking.shared.getSpeaker { (status, result) in
            if status {
                self.speakerData = result
                DispatchQueue.main.async {
                    self.speakerCollectionView.reloadData()
                }
            }
        }
    }
    
    func getSponsors(){
        firebaseNetworking.shared.getSponsor { (status, result) in
            if status {
                self.sponsorData = result
                DispatchQueue.main.async {
                    self.sponsorsCollectionView.reloadData()
                }
            }
        }
    }
    
    func getCollaborators(){
        firebaseNetworking.shared.getSponsor(isCollaborator: true) { (status, result) in
            if status {
                self.collaboratorData = result
                DispatchQueue.main.async {
                    self.collaboratorCollectionView.reloadData()
                }
            }
        }
    }
    
}

extension SpeakersViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collection(rawValue: collectionView.tag) {
        case .speakers:
            return speakerData.count
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
            cell.setupCell(speaker)
            cellToReturn = cell
        } else if collectionView.tag == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collaboratorIdentifier, for: indexPath) as! CollaboratorsCell
            let collaborator = collaboratorData[indexPath.item]
            cell.setImage(collaborator.logoUrl)
            cellToReturn = cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sponsorIdentifier, for: indexPath) as! SponsorsCell
            let sponsor = sponsorData[indexPath.item]
            cell.setImage(sponsor.logoUrl)
            cellToReturn = cell
        }
        return cellToReturn
    }
}

extension SpeakersViewController : UICollectionViewDelegate {
    
}

//extension SpeakersViewController : UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if !(collectionView.tag == 0){
//            let height =  sponsorsCollectionView.frame.height
//            return CGSize(width: height, height: height)
//        }
//    }
//}

enum collection : Int {
    case speakers = 0
    case collaborators = 1
    case sponsors = 2
}

