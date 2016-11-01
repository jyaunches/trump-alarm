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
    
    func intervalUntilPollsOpen() -> TimeInterval {
        let pollingOpening = TrumpAlarmUserDefaults.userPollingHours.pollsOpenDate
        return pollingOpening.timeIntervalSince(currentDate)
    }
    
    func intervalUntilPollsClose() -> TimeInterval {
        let pollingClosing = TrumpAlarmUserDefaults.userPollingHours.pollsCloseDate
        return pollingClosing.timeIntervalSince(currentDate)
    }
    
    func timeUntilNextElection() -> TimeInterval{
        let electionComponent = NSDateComponents()
        electionComponent.year = 2020
        electionComponent.month = 11
        electionComponent.day = 3
        
        let electionDay = calendar.date(from:electionComponent as DateComponents)!
     
        return electionDay.timeIntervalSince(currentDate)

    }
    
}
