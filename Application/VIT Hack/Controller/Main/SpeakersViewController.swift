//
//  SpeakersViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

class SpeakersViewController: UIViewController {
    
    //MARK:- COLLECTIONVIEWS
    @IBOutlet weak var speakerCollectionView: UICollectionView!
    @IBOutlet weak var collaboratorCollectionView: UICollectionView!
    @IBOutlet weak var sponsorsCollectionView: UICollectionView!
    
    //MARK- ABOUT US BUTTON
    @IBOutlet weak var aboutUsButton: UIButton!
    
    // COLLECTIONVIEW CELLS
    let speakerIdentifier = "speakercell"
    let collaboratorIdentifier = "Collaboratorcell"
    let sponsorIdentifier = "sponsorcell"
    
    // COLLECTIONVIEW DATASOURCES
    var collaboratorData : [SponsorData] = []
    var sponsorData  : [SponsorData] = []
    var speakerData : [SpeakersData] = []
    
    // MARK -- APP LIFECYLE METHODS --
    override func viewDidLoad() {
        super.viewDidLoad()
        loadOffline()
        getSpeakers()
        getSponsors()
        getCollaborators()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        speakerCollectionView.reloadData()
        aboutUsButton.bottomShadow()
    }
    
    // LOAD LOCAL DATA
    func loadOffline(){
        if let speaker = ControllerDefaults.speakers() { self.speakerData = speaker }
        if let sponsor = ControllerDefaults.sponsors() { self.sponsorData = sponsor }
        if let collaborator = ControllerDefaults.collaborators() { self.collaboratorData = collaborator }
    }
    
    // FETCH SPEAKERS
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
    
    // FETCH SPONSORS
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
    
    // FETCH COLLABORATORS
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

//MARK:- COLLECTIONVIEW DATASOURCE METHODS
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
            cell.join.addTarget(self, action: #selector(speakerJoin), for: .touchUpInside)
            cell.join.tag = indexPath.item
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.tag == 0{
            if let speakerCell = cell as? SpeakersCell{
                speakerCell.setupCell(speakerData[indexPath.item])
            }
        }
    }
}

//MARK:- COLLECTIONVIEW DELEGATE METHODS
extension SpeakersViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1{
            let collaborator = collaboratorData[indexPath.item]
            openWebsite(collaborator.pageUrl)
        } else if collectionView.tag == 2 {
            let sponsor = sponsorData[indexPath.item]
            openWebsite(sponsor.pageUrl)
        }
    }
}

//MARK:- COLLECTIONVIEW DELEGATEFLOWLAYOUT METHODS
extension SpeakersViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !(collectionView.tag == 0){
            return CGSize(width: 124, height: 124)
        } else {
            return CGSize(width: 200, height: 296)
        }
    }
}

extension SpeakersViewController {
    @objc func speakerJoin(sender:UIButton){
        let link = speakerData[sender.tag].sessionUrl
        openWebsite(link)
    }
}

enum collection : Int {
    case speakers = 0
    case collaborators = 1
    case sponsors = 2
}


//MARK: - CONTEXT MENU PREVIEW PROVIDER SETUP
@available(iOS 13.0, *)
extension SpeakersViewController {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        /// SETTING IDENTIFIER
        let tag = "\(collectionView.tag)"
        let path = "\(indexPath.item)"
        let id = tag+"-"+path
        let identifier = NSString(string: id)
        
        return UIContextMenuConfiguration(identifier: identifier as NSCopying, previewProvider: {
            guard let url = URL(string: self.findUrl(id) ?? "") else { return nil }
            return SFSafariViewController(url: url)
        }, actionProvider: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        animator.addCompletion {
            if let identifier = configuration.identifier as? String {
                guard let url = URL(string: self.findUrl(identifier) ?? "") else { return}
                let vc = SFSafariViewController(url: url)
                self.show(vc, sender: self)
            }
        }
    }
    
    func findUrl(_ id : String)->String?{
        let split = id.split(separator: "-")
        let tag = String(split[0])
        let row = Int(split[1])
        switch tag {
        case "0":
            return speakerData[row ?? 0].sessionUrl
        case "1":
            return collaboratorData[row ?? 0].pageUrl
        case "2":
            return sponsorData[row ?? 0].pageUrl
        default:
            return nil
        }
    }
}
