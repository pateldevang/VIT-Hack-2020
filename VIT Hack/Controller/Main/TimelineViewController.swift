//
//  TimelineViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import SafariServices

class TimelineViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var dayButtons: [UIButton]!
    
    var timeline = [TimelineData]()
    
    var filteredTimeline = [TimelineData]()
    
    var lastContentOffset: CGFloat = 0
    
    var lastDate : Int = 0
    
    var discordButton = UIButton(type: .custom)
    
    let cellIdentifier = "timelinecell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = ControllerDefaults.timeline() { self.timeline = data }
        firebaseNetworking.shared.getTimeline(completion: self.timelinehandler(status:timeline:))
        floatingButton()
 
        dayTapped(dayButtons[lastDate])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton()
        for button in dayButtons{
             button.layer.borderWidth = 1.0
             button.layer.borderColor = UIColor(named: "blue")?.cgColor
             button.layer.cornerRadius = button.frame.height/2
         }
    }
    
    @IBAction func dayTapped(_ sender: UIButton) {
        let blue = UIColor(named: "blue")
        dayButtons[lastDate].backgroundColor = .clear
        dayButtons[lastDate].setTitleColor(blue, for: .normal)
        lastDate = sender.tag
        dayButtons[lastDate].backgroundColor = blue
        dayButtons[lastDate].setTitleColor(.white, for: .normal)
        
        let day = sender.tag + 1
        let total = self.timeline
        filteredTimeline = total.filter { $0.day == day}
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func timelinehandler(status:Bool,timeline : [TimelineData]){
        if status{
            self.timeline = timeline
            self.dayTapped(dayButtons[self.lastDate])
        }
    }
    
    func floatingButton(){
        setDiscordFrame()
        discordButton.setTitle("Join Discord", for: .normal)
        discordButton.backgroundColor = #colorLiteral(red: 0, green: 0.4431372549, blue: 0.8039215686, alpha: 1)
        discordButton.clipsToBounds = true
        discordButton.addTarget(self,action: #selector(joinDiscord), for: .touchUpInside)
        view.addSubview(discordButton)
        discordButton.bottomShadow(radius: 0.0)
    }
    
    func setDiscordFrame(){
        let width = view.frame.width * 0.56
        let height = width / 4
        let tabHeight = tabBarController?.tabBar.frame.size.height ?? 0.0
        let y = view.frame.height - height - 15 - tabHeight
        discordButton.frame = CGRect(x: 285, y: y, width: width, height: height)
        discordButton.center.x = view.center.x
        discordButton.layer.cornerRadius = height/2
    }
    
    @objc func joinDiscord(){
        openWebsite(Social.discord)
    }
    
}

//MARK: Tableview delegate + datasource methods
extension TimelineViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTimeline.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TimelineCell
        
        let timelineData = filteredTimeline[indexPath.row]
        
        cell.setupCell(timelineData)
        
        cell.watchNowButton.addTarget(self, action: #selector(watchnow(sender:)), for: .touchUpInside)
        
        cell.watchNowButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = filteredTimeline[indexPath.row]
        var height = extimateFrameForText(text: data.subtitle ?? "", title: data.title ?? "")
        if !(data.link == "") {
            height += 60
        }
        return height + 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

extension TimelineViewController {
    private func extimateFrameForText(text: String, title : String) -> CGFloat {
        let width = (view.frame.width * 0.6) - 50
        
        let size = CGSize(width: width, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let height = NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Lato-Regular", size: 14)!], context: nil).height
        
        let titleHeight = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Lato-Italic", size: 20)!], context: nil).height
        
        return height + titleHeight
    }
}

extension TimelineViewController {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentOffset < scrollView.contentOffset.y {
            buttonTransition(down: true)
        } else if lastContentOffset > scrollView.contentOffset.y {
            buttonTransition(down: false)
        }
    }
    
    func buttonTransition(down : Bool){
        UIView.animate(withDuration: 0.3){
            self.discordButton.alpha = down ? 0.0 : 1.0
            let transform = CGAffineTransform(translationX: 0, y: 40)
            self.discordButton.transform = down ? transform : .identity
        }
    }
}

extension TimelineViewController {
    @objc func watchnow(sender : UIButton){
        let link = timeline[sender.tag].link
        openWebsite(link)
    }
}
