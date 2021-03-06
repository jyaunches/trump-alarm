//
//  Date+Extensions.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/30/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import Foundation

extension Date {

    static var endOfelectionDay: Date {
        get {
            //11pm EST Nov 8th
            return Date(timeIntervalSinceReferenceDate: 500356800)
        }
    }

    static var midnightOfelectionDay: Date {
        get {
            //11pm EST Nov 8th
            return Date(timeIntervalSinceReferenceDate: 500274000)
        }
    }
    
    static var isMoreThanThreeHoursFromPollsClose: Bool {
        get {
            let diff = Date().hour - TrumpAlarmUserDefaults.userPollingHours.pollsCloseDate.hour
            return diff > 3
        }
    }

    static func defaultPollsOpen() -> Date {
        let calendar = Calendar.current
        let closeComponent = NSDateComponents()
        closeComponent.year = 2016
        closeComponent.month = 11
        closeComponent.day = 8
        closeComponent.hour = 8
        closeComponent.minute = 0
        closeComponent.second = 0
        return calendar.date(from: closeComponent as DateComponents)!
    }

    static func defaultPollsClose() -> Date {
        let calendar = Calendar.current
        let closeComponent = NSDateComponents()
        closeComponent.year = 2016
        closeComponent.month = 11
        closeComponent.day = 8
        closeComponent.hour = 22
        closeComponent.minute = 0
        closeComponent.second = 0
        return calendar.date(from: closeComponent as DateComponents)!
    }

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
        let electionDay = Date.midnightOfelectionDay
        print("Election day: \(electionDay.standardPrint())")
        
        let today = Date()
        var intervals: [TimeInterval] = []
        
        if electionDay > Date() {
            //TODO: update the 0 below to Date() on Nov 1
            let daysLeft = electionDay.day - today.day

            let todaysInterval = (22.minutes.fromNow() ?? Date()).timeIntervalSinceReferenceDate - today.timeIntervalSinceReferenceDate
            intervals.append(todaysInterval)

            var dayIntervalIndex = 1
            while dayIntervalIndex < daysLeft {
                let randomSec = Int.random(range: 0 ..< 60)
                let randomMin = Int.random(range: 0 ..< 60)
                let randomHour = Int.random(range: 9 ..< 20)

                let alertDate = electionDay - dayIntervalIndex.days

                let intervalDate = try! alertDate.atTime(hour: randomHour, minute: randomMin, second: randomSec)
                intervals.append(intervalDate.timeIntervalSinceReferenceDate - today.timeIntervalSinceReferenceDate)
                dayIntervalIndex += 1
            }
        }

        return intervals
    }

    static func earlyIntervalsOnElectionDay(electionDayStart: Date, electionDayEnd: Date) -> [TimeInterval] {
        var intervals: [TimeInterval] = []
        let today = NSDate()

        var startHour = electionDayStart.hour
        let endHour = electionDayEnd.hour - 3

        while startHour < endHour {
            for _ in 1...2 {
                let randomSec = Int.random(range: 0 ..< 60)
                let randomMin = Int.random(range: 0 ..< 60)
                
                let intervalDate = try! electionDayStart.atTime(hour: startHour, minute: randomMin, second: randomSec)
                intervals.append(intervalDate.timeIntervalSinceReferenceDate - today.timeIntervalSinceReferenceDate)
            }
            
            startHour += 1
        }

        return intervals
    }

    static func laterIntervalsOnElectionDay(electionDayStart: Date, electionDayEnd: Date) -> [TimeInterval] {
        var intervals: [TimeInterval] = []
        let today = NSDate()

        var startHour = electionDayEnd.hour - 3
        let endHour = electionDayEnd.hour

        while startHour < endHour {
            for _ in 1...4 {
                let randomSec = Int.random(range: 0 ..< 60)
                let randomMin = Int.random(range: 0 ..< 60)

                let intervalDate = try! electionDayStart.atTime(hour: startHour, minute: randomMin, second: randomSec)
                intervals.append(intervalDate.timeIntervalSinceReferenceDate - today.timeIntervalSinceReferenceDate)
            }

            startHour += 1
        }

        return intervals
    }

}
