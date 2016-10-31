//
//  PollingAPIResponseParser.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/31/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class PollingAPIResponse: NSObject {
    
    var calendar = Calendar.current    
    
    var pollsOpenDate = Date.defaultPollsOpen()
    var pollsCloseDate = Date.defaultPollsClose()
    
    convenience init(response: String?) {
        self.init()
        if let response = response {
            let dashSeperated = response.components(separatedBy: " - ")
            
            let openingComponents = getPollingTimeComponents(openTime: dashSeperated[0])
            let closingComponents = getPollingTimeComponents(openTime: dashSeperated[1])
            
            pollsOpenDate = timeUntilPollsOpen(timeArray: openingComponents)
            pollsCloseDate = timeUntilPollsClose(timeArray: closingComponents)
        }
    }
    
    func timeUntilPollsOpen(timeArray: [String]) -> Date {
        let openComponent = NSDateComponents()
        openComponent.year = 2016
        openComponent.month = 11
        openComponent.day = 8
        openComponent.hour = Int(timeArray[0])!
        openComponent.minute = Int(timeArray[1])!
        openComponent.second = Int(timeArray[2])!
        return calendar.date(from:openComponent as DateComponents)!
    }
    
    func timeUntilPollsClose(timeArray: [String]) -> Date {
        let closeComponent = NSDateComponents()
        closeComponent.year = 2016
        closeComponent.month = 11
        closeComponent.day = 8
        closeComponent.hour = Int(timeArray[0])! + 12
        closeComponent.minute = Int(timeArray[1])!
        closeComponent.second = Int(timeArray[2])!
        return calendar.date(from:closeComponent as DateComponents)!
    }

    private func getPollingTimeComponents(openTime: String) -> Array<String> {
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

}
