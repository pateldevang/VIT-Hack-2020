//
//  OnboardingViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 16/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    let cellIdentifier = "OnboardingCell"
    let onboardingData : [Onboarding] = [.init(title1: "Welcome to", title2: "VIT HACK", image: #imageLiteral(resourceName: "1"), body: "The hackathon will be focusing on the feasibility, application, resourcefulness and fundability of each project idea presented by the participants"),.init(title1: "Some catchy", title2: "Headline here", image: #imageLiteral(resourceName: "2"), body: "Real-world problem statement aimed towards challenging yout abilities and tons more is in store for you"),.init(title1: "Some catchy", title2: "Headline here", image: #imageLiteral(resourceName: "3"), body: "VITHack isa 36-Hur hackathon spread over the course of 3 days. Participants are continually encouraged to network with industry professionals in this confluence of knowledge and ideas")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        pageControl.transform = CGAffineTransform(scaleX: 2, y: 2)
    }
    @IBAction func skip(_ sender: Any) {
        performSegue(withIdentifier: "home", sender: nil)
    }
}

extension OnboardingViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! OnboardingCell
        
        let data = onboardingData[indexPath.item]
        cell.setupCell(data)
        
        return cell
    }
}

extension OnboardingViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        return CGSize(width: frame.width, height: frame.height)
    }
}


extension OnboardingViewController :UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}


struct Onboarding {
    let title1 : String
    let title2 : String
    let image : UIImage
    let body : String
}
