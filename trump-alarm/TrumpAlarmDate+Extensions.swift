//
//  Date+Extensions.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/30/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import Foundation

extension Date {
    
    func standardPrint() -> String? {
        if inRegion().isToday {
            return "Today \(timeOnly())"
        } else {
            return "\(dayPrint()) \(timeOnly())"
        }
    }

    func timeOnly() -> String {
        return inRegion().string(format: DateFormat.custom("HH:mm.ss"))
    }

    func dayPrint() -> String {
        return inRegion().string(format: DateFormat.custom("MM.dd.YY"))
    }

    static func intervalsUntilElectionDay() -> [TimeInterval] {
        let electionDay = Date(timeIntervalSinceReferenceDate: 500274000)
                
        print("Election day: \(electionDay.standardPrint())")
        
        //TODO: update the 0 below to Date() on Nov 1
        let today = Date()
        let daysLeft = electionDay.day - 0
        
        let todaysInterval = (22.minutes.fromNow() ?? Date()).timeIntervalSinceReferenceDate  - today.timeIntervalSinceReferenceDate
        var intervals: [TimeInterval] = [todaysInterval]
        
        var dayIntervalIndex = 1
        while dayIntervalIndex < daysLeft {
            //TODO: put back in after testing
            //let randomSec = Int.random(range: 0..<60)
            //let randomMin = Int.random(range: 0..<60)
            //let randowmHour = Int.random(range: 9..<20)
            
            let alertDate = electionDay - dayIntervalIndex.days
            
            let intervalDate = try! alertDate.atTime(hour: 14, minute: 0, second: 0)
            intervals.append(intervalDate.timeIntervalSinceReferenceDate - today.timeIntervalSinceReferenceDate)
            dayIntervalIndex += 1
        }
        
        return intervals
    }
    
    static func intervalsOnElectionDay() -> [TimeInterval] {
        let utcDate = (Date() + 5.second).inRegion()
        return [utcDate.timeIntervalSinceReferenceDate]
    }
    
}
