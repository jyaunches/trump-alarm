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
    
    private func getOpeningTimeComponents(openTime: String) -> Array<String> {
        let hour: String
        let minute: String
        let seconds = "00"
        let wsSeperated = openTime.components(separatedBy: " ")
        let hourAndMinute = wsSeperated[0].components(separatedBy: ":")
        hour = hourAndMinute[0]
        if hourAndMinute.count == 2 {
            minute = hourAndMinute[1]
        } else {
            minute = "00"
        }
        TrumpAlarmUserDefaults.storePollStart(hour: Int(hour)!)
        
        return [hour, minute, seconds]
    }
    
    private func getClosingTimeComponents(closeTime: String) -> Array<String> {
        let hour: String
        let minute: String
        let seconds = "00"
        
        let wsSeperated = closeTime.components(separatedBy: " ")
        let hourAndMinute = wsSeperated[0].components(separatedBy: ":")
        hour = hourAndMinute[0]
        if hourAndMinute.count == 2 {
            minute = hourAndMinute[1]
        } else {
            minute = "00"
        }
        TrumpAlarmUserDefaults.storePollEnd(hour: Int(hour)!)

        return [hour, minute, seconds]
    }
    
    func timeUntilPollsOpen() -> Date {
        let openArray = getOpeningTimeComponents(openTime: UserDefaults.standard.string(forKey: "pollStartString")!)
        
        let openComponent = NSDateComponents()
        openComponent.year = 2016
        openComponent.month = 11
        openComponent.day = 8
        openComponent.hour = Int(openArray[0])!
        openComponent.minute = Int(openArray[1])!
        openComponent.second = Int(openArray[2])!
        return calendar.date(from:openComponent as DateComponents)!
    }
    
    func timeUntilPollsClose() -> Date {
        let closeArray = getClosingTimeComponents(closeTime: UserDefaults.standard.string(forKey: "pollEndString")!)
        
        let closeComponent = NSDateComponents()
        closeComponent.year = 2016
        closeComponent.month = 11
        closeComponent.day = 8
        closeComponent.hour = Int(closeArray[0])! + 12
        closeComponent.minute = Int(closeArray[1])!
        closeComponent.second = Int(closeArray[2])!
        return calendar.date(from:closeComponent as DateComponents)!
    }
    
    func timeUntilNextElection() -> TimeInterval{
        let electionComponent = NSDateComponents()
        electionComponent.year = 2020
        electionComponent.month = 11
        electionComponent.day = 3
        
        let electionDay = calendar.date(from:electionComponent as DateComponents)!
     
        return electionDay.timeIntervalSince(currentDate)

    }
    
    func timeBetweenOpenAndClose() -> TimeInterval {

        let timeUntilPollsClose = self.timeUntilPollsClose()
        let timeUntilPollsOpen = self.timeUntilPollsOpen()
        
        return timeUntilPollsClose - timeUntilPollsOpen
        
    }
    
    private func setTimeDefaults(pollHours: String) {
        
        let dashSeperated = pollHours.components(separatedBy: " - ")

        TrumpAlarmUserDefaults.storePollStartString(hour: dashSeperated[0])
        TrumpAlarmUserDefaults.storePollEndString(hour: dashSeperated[1])
    }
    
}
