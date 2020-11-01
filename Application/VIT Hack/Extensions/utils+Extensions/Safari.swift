//
//  Safari.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 20/09/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import UIKit
import SafariServices

//MARK: open SFSafariController with urlString.
extension UIViewController : SFSafariViewControllerDelegate{
    func openWebsite(_ link : String?){
        if let link = link,let url = URL(string: link) {
            if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
                let safariVC = SFSafariViewController(url: url)
                self.present(safariVC, animated: true, completion: nil)
                safariVC.delegate = self
            }
        }
    }
}
