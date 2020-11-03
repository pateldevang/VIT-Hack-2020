//
//  TimelineViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    /// tableView to display `Timeline`
    @IBOutlet weak var tableView: UITableView!
    
    /// `Total timeline` { To be divided into 3 }
    var timeline = [TimelineData](){
        didSet{
            self.filteredTimeline[0] = timeline.filter { $0.day == 1 } /// Day 1 timeline
            self.filteredTimeline[1] = timeline.filter { $0.day == 2 } /// Day 2 timeline
            self.filteredTimeline[2] = timeline.filter { $0.day == 3 } /// Day 3 timeline
        }
    }
    
    /// `datasource` for tableView
    var filteredTimeline : [[TimelineData]] = [[],[],[]]{
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    /// Offset to determine visibility of `Discord button`
    var lastContentOffset: CGFloat = 0
    
    /// `Discord` button added programatically
    var discordButton = UIButton(type: .custom)
    
    /// `CellID`  for TimelineCell
    let cellIdentifier = "timelinecell"
    
    /// Section `Headers` for tableView
    let sections = ["Start","10 October 2020","11 October 2020"]
    
    //MARK --- LIFECYCLE METHODS ---
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = ControllerDefaults.timeline() { self.timeline = data }  /// fetch local timeline
        firebaseNetworking.shared.getTimeline(completion: self.timelinehandler(status:timeline:))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton() /// ADD discord button
    }
    
    
    /// Filter `Timeline` data fetched from firebase
    func timelinehandler(status:Bool,timeline : [TimelineData]){
        if status{
            self.filteredTimeline[0] = timeline.filter { $0.day == 1 }
            self.filteredTimeline[1] = timeline.filter { $0.day == 2 }
            self.filteredTimeline[2] = timeline.filter { $0.day == 3 }
        }
    }
    
}

//MARK: Tableview delegate + datasource methods
extension TimelineViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredTimeline.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTimeline[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TimelineCell
        
        let timelineData = filteredTimeline[indexPath.section][indexPath.row]
        
        cell.setupCell(timelineData)
        
        cell.watchNowButton.addTarget(self, action: #selector(watchnow(sender:)), for: .touchUpInside)
        
        cell.watchNowButton.tag = (indexPath.section * 10) + indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! TimelineHeader
        cell.header.text = sections[section]
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    @objc func watchnow(sender : UIButton){
        let row = sender.tag % 10
        let section = sender.tag / 10
        let link = filteredTimeline[section][row].link
        openWebsite(link)
    }
}

//MARK: - Extension to determine height of tableView Cell
extension TimelineViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = filteredTimeline[indexPath.section][indexPath.row]
        var height = extimateFrameForText(text: data.subtitle ?? "", title: data.title ?? "")
        if !(data.link == "") {
            height += 60
        }
        return height + 70
    }
    
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

//MARK: - Extension to setup Discord Button
extension TimelineViewController {
    /// ADD BUTTON TO VIEW
    func floatingButton(){
        setDiscordFrame()
        discordButton.setTitle("Join Discord", for: .normal)
        discordButton.backgroundColor = #colorLiteral(red: 0, green: 0.4431372549, blue: 0.8039215686, alpha: 1)
        discordButton.clipsToBounds = true
        discordButton.addTarget(self,action: #selector(joinDiscord), for: .touchUpInside)
        view.addSubview(discordButton)
        discordButton.bottomShadow(radius: 0.0)
    }
    
    // DISCORD BUTTON LAYOUT SETUP
    func setDiscordFrame(){
        let width = view.frame.width * 0.56
        let height = width / 4
        let tabHeight = tabBarController?.tabBar.frame.size.height ?? 0.0
        let y = view.frame.height - height - 15 - tabHeight
        discordButton.frame = CGRect(x: 285, y: y, width: width, height: height)
        discordButton.center.x = view.center.x
        discordButton.layer.cornerRadius = height/2
    }
    
    // DISCORD BUTTON IBACTION
    @objc func joinDiscord(){
        openWebsite(Social.discord)
    }
}
