//
//  Int+Extensions.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/30/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import Foundation

extension Int
{
    static func random(range: Range<Int>) -> Int
    {
        var offset = 0
        
        if range.upperBound < 0   // allow negative ranges
        {
            offset = abs(range.upperBound)
        }
        
        let maxi = UInt32(range.upperBound + offset)
        let mini = UInt32(range.lowerBound + offset)
        
        let randomNum = arc4random_uniform(maxi - mini)
        return Int(mini + randomNum) - offset
    }

}
