//
//  TracksViewController.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 30/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit

class TracksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subtitel: UILabel!
    
    var domain = DomainData()
    var tracks = [String]()
    
    let tracksCellIdentifier = "trackscell"
    
    override func viewDidLoad() {
        subtitel.text = domain.domain ?? ""
    }
}

extension TracksViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tracksCellIdentifier) as! TracksCell
        cell.body.text = tracks[indexPath.row]
        cell.header.text = "PS-" + (self.domain.domain?.domainShortValue ?? "") + "-0" + String(indexPath.row+1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = tracks[indexPath.row]
        let height = extimateFrameForText(text : text)
        return height + 150
    }
    
}

extension TracksViewController {
    private func extimateFrameForText(text: String) -> CGFloat {
        let width = view.frame.width - 75
        
        let size = CGSize(width: width, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let height = NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.init(name: "Lato-Regular", size: 14)!], context: nil).height
        
        return height
    }
}
