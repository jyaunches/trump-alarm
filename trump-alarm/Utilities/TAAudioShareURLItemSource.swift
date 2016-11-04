//
//  TAAudioShareURLItemSource.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 11/3/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class TAAudioShareURLItemSource: NSObject, UIActivityItemSource {
    var trumpQuote: TrumpQuote?
    
    init(quote: TrumpQuote) {
        super.init()
        self.trumpQuote = quote
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType) -> Any? {
        if activityType == UIActivityType.message {
            if let url = trumpQuote?.audioFileURL {
                return url
            }
        }
        return NSURL(string: "https://itunes.apple.com/us/app/trumpalarm/id1170297463")
    }
}
