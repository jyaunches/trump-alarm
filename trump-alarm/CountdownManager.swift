//
//  CountdownManager.swift
//  trump-alarm
//
//  Created by Stephanie Guevara on 10/30/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class CountdownManager: NSObject {
    var date = Date()
    var calendar = Calendar.current
    lazy var currentDate : Date = self.getCurrentDate()
    
    func getCurrentDate() -> Date {
        let components = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: date)
        return calendar.date(from: components)!
    }
    
    func translatePollClosingTime(pollTimes: String) -> Array<String> {
        let hour: String
        let minute: String
        let seconds = "00"
        
        let dashSeperated = pollTimes.components(separatedBy: " - ")
        let wsSeperated = dashSeperated[1].components(separatedBy: " ")
        let hourAndMinute = wsSeperated[0].components(separatedBy: ":")
        hour = hourAndMinute[0]
        if hourAndMinute.count == 2 {
            minute = hourAndMinute[1]
        } else {
            minute = "00"
        }

        return [hour, minute, seconds]
    }
    
    func getCountdownData(pollHours: String) -> TimeInterval {
        
        let timeComponents = translatePollClosingTime(pollTimes: pollHours)
        
        let pollComponent = NSDateComponents()
        pollComponent.year = 2016
        pollComponent.month = 11
        pollComponent.day = 8
        pollComponent.hour = Int(timeComponents[0])!
        pollComponent.minute = Int(timeComponents[1])!
        pollComponent.second = Int(timeComponents[2])!
        let pollClosingTime = calendar.date(from:pollComponent as DateComponents)!
    
        
        return pollClosingTime.timeIntervalSince(currentDate)

    }
    
    
}
