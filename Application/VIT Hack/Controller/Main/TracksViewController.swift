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
    @IBOutlet weak var crossButton: UIButton!
    
    var domain = DomainData()
    var tracks = [psModel]()
    
    let tracksCellIdentifier = "trackscell"
    
    override func viewDidLoad() {
        tableView.delegate = self
        subtitel.text = (domain.description ?? "") + ("\nTap on a problem statement to know more!")
        if #available(iOS 13, *){
            crossButton.isHidden = true
        } else {
            crossButton.outline()
        }
        print(tracks)
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension TracksViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tracksCellIdentifier) as! TracksCell
        let url = tracks[indexPath.row].url
        cell.indicator.isHidden = !isUrl(url)
        cell.body.text = tracks[indexPath.row].text
        cell.header.text = "PS-" + (domain.abbreviation ?? "") + "-0" + String(indexPath.row+1)
        return cell
    }
    
    func isUrl(_ link: String?)->Bool {
        if let link = link,let url = URL(string: link) {
            if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
                return true
            } else {
            return false
            }
        } else {
            return false
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let text = tracks[indexPath.row].text ?? ""
        let height = extimateFrameForText(text : text)
        return height + 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = tracks[indexPath.row].url
        tableView.deselectRow(at: indexPath, animated: true)
        openWebsite(url)
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
