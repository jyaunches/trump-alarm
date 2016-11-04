//
//  TAShareURLItemSource.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 11/3/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class TAShareURLItemSource: NSObject, UIActivityItemSource {
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "https://itunes.apple.com/us/app/trumpalarm/id1170297463"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType) -> Any? {
        if activityType == UIActivityType.message {
            return NSURL(string: "itms-apps://itunes.apple.com/app/id1170297463")
        }
        return NSURL(string: "https://itunes.apple.com/us/app/trumpalarm/id1170297463")
    }
}
