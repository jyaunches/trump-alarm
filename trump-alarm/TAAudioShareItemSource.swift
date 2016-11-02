//
// Created by Julietta Yaunches on 11/2/16.
// Copyright (c) 2016 yaunches. All rights reserved.
//

import UIKit

class TAAudioShareItemSource: NSObject, UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType) -> Any? {
        if activityType == UIActivityType.postToTwitter {
            return "Sound presidential? Wake up & vote for Hillary. Download @TrumpAlarm - the most offensive & effective alarm clock"  as AnyObject
        }
        return "Does that sound Presidential? Wake up and Vote for Hillary. Download the Trump Alarm -- the most offensive and effective alarm clock ever."
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
