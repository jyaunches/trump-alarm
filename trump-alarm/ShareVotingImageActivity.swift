//
// Created by Julietta Yaunches on 11/2/16.
// Copyright (c) 2016 yaunches. All rights reserved.
//

import UIKit

class TAPhotoShareItemSource: NSObject, UIActivityItemSource {

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType) -> Any? {

        if activityType == UIActivityType.message {
            return "Need a reminder to wake up and vote for Hillary on 11/8? Download the Trump Alarm - the most offensive and effective alarm clock ever." as AnyObject
        } else if activityType == UIActivityType.mail {
            return "Need a reminder of why you should wake up and vote for Hillary on November 8th? The Trump Alarm spews frightening Trump sounds bites every hour on the hour from the time the polls open to the time polls close on Election Day. The only way to turn off the most annoying, offensive, and effective alarm clock ever is by voting. Download and Make America Wake Up and Vote Again."  as AnyObject
        } else if activityType == UIActivityType.postToTwitter {
            return "Need a reminder to wake up &amp; vote for Hillary on 11/8? Download the @TrumpAlarm - the most offensive alarm clock."  as AnyObject
        } else if activityType == UIActivityType.postToFacebook {
            return "Need a reminder of why you should wake up and vote for Hillary on November 8th? The Trump Alarm spews frightening Trump sounds bites every hour on the hour from the time the polls open to the time polls close on Election Day. The only way to turn off the most annoying, offensive and effective alarm clock ever is by voting. Download and Make America Wake Up and Vote Again."  as AnyObject
        }
        return "Need a reminder to wake up and vote for Hillary on 11/8? Download the Trump Alarm - the most offensive and effective alarm clock ever."
    }

    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivityType?) -> String {
        return "Trump Alarm - Wake up and vote!"
    }

    func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivityType?, suggestedSize size: CGSize) -> UIImage? {

        if let beginningImage = UIImage(named: "TrumpMouth") {
            let newWidth = size.width

            let scale = newWidth / beginningImage.size.width
            let newHeight = beginningImage.size.height * scale
            UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
            beginningImage.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage
        }
        return nil
    }
}
