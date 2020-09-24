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
    let onboardingData : [Onboarding] = [.init(title1: "Welcome to", title2: "VIT HACK", image: #imageLiteral(resourceName: "1"), body: "VIT Hack is one of the best Pan-Indian hack-a-thons where participants creatively use cutting edge technology to solve societal problems, and compete for exciting prizes."),.init(title1: "Problem Statements", title2: "on their way", image: #imageLiteral(resourceName: "2"), body: "Get a chance to learn, ideate and grow. Pitch your wildest ideas to real-life investors and win the opportunity of getting invested, internships and many more!"),.init(title1: "Let’s hustle", title2: "to solve and win!", image: #imageLiteral(resourceName: "3"), body: "From Mentor talks, webinars, mentorships, project collabs, workshops, forums to discuss and many more...VIT Hack being a major hack-a-thon, compete at a high level and gain tremendous exposure.")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        pageControl.transform = CGAffineTransform(scaleX: 2, y: 2)
    }
    
    @IBAction func skip(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: Keys.onboard)
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
