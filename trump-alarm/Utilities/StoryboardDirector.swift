//
//  StoryboardDirector.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/31/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class StoryboardDirector: NSObject {
    static let sharedInstance = StoryboardDirector()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func buildQuotePlaying(quote: TrumpQuote) -> QuotePlayViewController? {
        var result: QuotePlayViewController?
        if let vc = storyboard.instantiateViewController(withIdentifier: "QuotePlayViewController") as? QuotePlayViewController {
            vc.trumpQuote = quote
            result = vc
        }
        return result
    }
    
    func buildMainCountdown() -> MainViewController? {
        var result: MainViewController?
        if let vc = storyboard.instantiateViewController(withIdentifier: "MainCountDownVC") as? MainViewController {
            result = vc
        }
        return result
    }
}
