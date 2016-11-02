//
//  CustomMessageActivityItemProvider.swift
//  trump-alarm
//
//  Created by Stephanie Guevara on 11/2/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class CustomMessageActivityItemProvider: UIActivityItemProvider {
    
    override var item: Any {
        
        if let url = NSURL(string: "http://www.trumpalarm.com") {

        
            if activityType == UIActivityType.postToFacebook {
                return [Environment.Share.fbCopy, url]

            }
            else if activityType == UIActivityType.mail {
            }
            else if activityType == UIActivityType.message {
            }
            else if activityType == UIActivityType.postToTwitter {
            }
            else if activityType == UIActivityType.postToFacebook {
                return Environment.Share.fbCopy
            }
            else {
                    return placeholderItem ?? ""
            }
        }
        return Environment.Share.defaultCopy
    }
}
