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
    
    func translatePollClosingTime(pollTimes: String) -> Date {
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
        
        let closingTime = hour + ":" + minute + ":" + seconds
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        
        var dateString = dateFormatter.date(from:closingTime)
        
        return dateFormatter.date(from: closingTime)!
    }
    
    func getCountdownData(pollClotingTime: String) {
        
        // here we set the due date. When the timer is supposed to finish
        
        let pollComponent = NSDateComponents()
        pollComponent.year = 2016
        pollComponent.month = 11
        pollComponent.day = 8
//        pollComponent.hour = hour!
//        pollComponent.minute = minutes!
        let pollClosingTime = calendar.date(from:pollComponent as DateComponents)!
        
        
        // Here we compare the two dates
//        pollClosingTime.timeIntervalSince(pollClosingTime)
//        
//        let dayCalendarUnit: NSCalendar.Unit = ([.day, .hour, .minute])
//        
//        //here we change the seconds to hours,minutes and days
//        let countdownTime = calendar.compare(currentDate!, to: pollClosingTime, toGranularity: .second)
//        
//        var daysLeft = pollClosingTime.day
//        var hoursLeft = pollClosingTime.hour
//        var minutesLeft = pollClosingTime.minute
//        
    }
    
    
}
