//
//  TimelineViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 15/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var timeline = [TimelineData]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let cellIdentifier = "timelinecell"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseNetworking.shared.getTimeline(completion: timelinehandler(status:timeline:))
    }
    
    func timelinehandler(status:Bool,timeline : [TimelineData]){
        if status{
            self.timeline = timeline
            print(timeline)
        }
    }
    
    
}

//MARK: Tableview delegate + datasource methods
extension TimelineViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeline.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TimelineCell
        
        let timelineData = timeline[indexPath.row]
        
        cell.setupCell(timelineData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    //TODO dynamic height
    //TODO add watch now button
}
