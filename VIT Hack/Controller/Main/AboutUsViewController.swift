//
//  AboutUsViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class AboutUsViewController: UIViewController {
    
    /// Collectionview to present `AboutUs` data.
    @IBOutlet weak var collectionview: UICollectionView!
    
    /// `datasource` of collectionview
    var aboutUs = [
        AboutUsData(name: "Aaryan Kothari", role: "iOS Developer", image: "aaryan", socialHandles: [.github,.LinkedIn,.mail], socailUrls: ["https://github.com/aaryankotharii","https://www.linkedin.com/in/aaryankotharii/","aaryan.kothari@gmail.com"]),
        AboutUsData(name: "Devang Patel", role: "iOS Developer", image: "devang", socialHandles: [.github,.LinkedIn,.mail], socailUrls: ["https://github.com/pateldevang","https://www.linkedin.com/in/devangpatel-in/","devangdayalal.patel2018@vitstudent.ac.in"]),
        AboutUsData(name: "Garima Bothra", role: "iOS Developer", image: "garima", socialHandles: [.github,.LinkedIn,.mail], socailUrls: ["https://github.com/garima94921","https://www.linkedin.com/in/garima-bothra/","gaarimabothra@gmail.com"]),
        AboutUsData(name: "Rohan Arora", role: "UX/UI Designer", image: "rohan", socialHandles: [.dribble,.LinkedIn,.mail], socailUrls: ["https://rohanxdesign.in","https://www.linkedin.com/in/rohanxdesign/","rohanxdesign@gmail.com"]),
        AboutUsData(name: "Hemanth Krishna", role: "Android Developer", image: "hemanth", socialHandles: [.github,.LinkedIn,.mail], socailUrls: ["https://github.com/DarthBenro008","https://www.linkedin.com/in/darthbenro008","hemanth.krishna2019@vitstudent.ac.in"]),
        AboutUsData(name: "Vibhor Chinda", role: "Android Developer", image: "vibhor", socialHandles: [.github,.LinkedIn,.mail], socailUrls: ["https://github.com/VibhorChinda","https://www.linkedin.com/in/vibhor-chinda-465927169/","vibhorchinda@gmail.com"])]
    
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
        cell.layoutIfNeeded()
        cell.name.text = data.name
        cell.profilePhoto.image = UIImage(named: data.image)
        cell.designation.text = data.role
        let width = calculateSize().width * 0.625
        cell.setupCell(data.socialHandles, photoRadius: (width-12)/2, backRadius: width/2)
        cell.delegate = self
        cell.button1.tag = (10 * indexPath.item)
        cell.button2.tag = (10 * indexPath.item) + 1
        cell.button3.tag = (10 * indexPath.item) + 2
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
        if id == 2{
            self.sendEmail(email: url)
        }
    }
    
}

//MARK:- CollectionView FlowLayout Methods
extension AboutUsViewController : UICollectionViewDelegateFlowLayout{
    
    /// Dynamic cell size `According to screen size!`
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return calculateSize()
    }
    
    func calculateSize()->CGSize{
        let width = view.frame.width - 80
        if width > 250 {
            let cellWidth = width/2
            let cellHeight = cellWidth * 4/3
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            let cellHeight = width * 4/3
            return CGSize(width: width, height: cellHeight)
        }
    }
}

extension AboutUsViewController : SocialDelegate {
    func didPressButton(_ tag: Int) {
        let button = tag%10
        let index = tag/10
        didSelectItemAtIndex(person: aboutUs[index], social: button)
    }
}

extension AboutUsViewController : MFMailComposeViewControllerDelegate{
    func sendEmail(email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setMessageBody("<p>VIT Hacks iOS app is amazing!</p>", isHTML: true)
            
            present(mail, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
