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
    var tracks = [String]()
    
    let tracksCellIdentifier = "trackscell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}

extension TracksViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tracksCellIdentifier) as! TracksCell
        cell.body.text = tracks[indexPath.row]
        return cell
    }
    

    
}
