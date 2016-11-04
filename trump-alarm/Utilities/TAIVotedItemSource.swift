//
//  TAIVotedItemSource.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 11/3/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class TAIVotedItemSource: NSObject {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "Trump Alarm - Wake up and vote!"
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType) -> Any? {
        if (activityType == UIActivityType.postToTwitter) || (activityType == UIActivityType.postToFacebook) {
            return "I voted for Hillary! Need a push to the polls? Download the most offensive alarm clock. @TrumpAlarm" as AnyObject
        }
        return "I voted for Hillary! Need a push to the polls? Download the most offensive alarm clock."
    }

    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivityType?) -> String {
        return "Trump Alarm - Wake up and vote!"
    }

}
