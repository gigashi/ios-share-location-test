//
//  ViewController.swift
//  ShareLocationTest
//
//  Created by higashi_yo on 2019/08/16.
//  Copyright © 2019 gigashi. All rights reserved.
//

import UIKit
import CoreLocation
import MobileCoreServices

class ViewController: UIViewController {
    
    @IBAction func onClickShareLocationButton(_ sender: UIButton) {
        shareLocation(CLLocation(latitude: 35, longitude: 135))
    }

    // refer to https://josephduffy.co.uk/ios-share-sheets-the-proper-way-locations
    private func shareLocation(_ location: CLLocation) {
        let title = "Shared Location"
        let urlString = "https://maps.apple.com?ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
        guard let url = NSURL(string: urlString) else { return }
        
        guard let vcard = [
            "BEGIN:VCARD",
            "VERSION:3.0",
            "PRODID:-//Joseph Duffy//Blog Post Example//EN",
            "N:;\(title);;;",
            "FN:\(title)",
            "item1.URL;type=pref:\(urlString)",
            "item1.X-ABLabel:map url",
            "END:VCARD"
        ].joined(separator: "\n").data(using: .utf8) else { return }
        
        let activityItems = [
            url,
            NSItemProvider(item: vcard as NSSecureCoding, typeIdentifier: kUTTypeVCard as String),
            title,
        ] as [Any]
        
        let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(vc, animated: true, completion: nil)
    }
}
