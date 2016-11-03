//
//  NotificationManager.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/29/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {

    static let sharedInstance = NotificationManager()

    let center = UNUserNotificationCenter.current()
    var requests: [UNNotificationRequest] = []
    var quoteLibrary = TrumpQuoteLibrary()

    override init() {
        super.init()

        center.delegate = self
    }

    func spew() {
        let randomNum = Int.random(range: 0..<100)
        schedule(intervals: [3], prefixId: "SPEW-\(randomNum)")
    }

    func setupAppropriatePolling() {
        requestNotificationPermission() {
            self.center.removeAllPendingNotificationRequests()
            self.spew()
            self.setupPrePolling()
            self.setupEarlyPollingDay()
            self.setupLaterPollingDay()
        }
    }

    func cancelFutureNotififications() {
        self.center.removeAllPendingNotificationRequests()
    }

    func setupPrePolling() {

        let intervals: [TimeInterval] = Date.intervalsUntilElectionDay()
        schedule(intervals: intervals, prefixId: "PRE-ELECTION")

    }

    func setupEarlyPollingDay() {
        let pollingHours = TrumpAlarmUserDefaults.userPollingHours
        let intervals = Date.earlyIntervalsOnElectionDay(electionDayStart: pollingHours.pollsOpenDate, electionDayEnd: pollingHours.pollsCloseDate)
        schedule(intervals: intervals, prefixId: "EARLY-ELECTION-DAY")
    }

    func setupLaterPollingDay() {
        let pollingHours = TrumpAlarmUserDefaults.userPollingHours
        let intervals = Date.laterIntervalsOnElectionDay(electionDayStart: pollingHours.pollsOpenDate, electionDayEnd: pollingHours.pollsCloseDate)
        schedule(intervals: intervals, prefixId: "LATER-ELECTION-DAY")
    }

    func requestNotificationPermission(onAgree: (() -> Void)?) {
        center.requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
            if granted {
                onAgree?()
            }
        }
    }

    func schedule(intervals: [TimeInterval], prefixId: String) {
        for interval in intervals {
            if interval > 0 {
                let quote = self.quoteLibrary.getRandomQuote(idPrefix: "\(prefixId)-\(interval)")

                let notRequest = TrumpAlarmNotification.build(quote: quote, interval: interval)

                let actualAlarmDate = Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate + interval)
                print("Scheduling \(prefixId) alarm for: \(actualAlarmDate.standardPrint() ?? "N/A"))\nAudio: \(quote.audioFile)\nIdentifier: \(quote.identifier)")

                center.add(notRequest) {
                    (error) in

                    if (error != nil) {
                        print("Error scheduling notification: \(error)")
                    }
                }
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        
        /*
        let quote = notification.request.content.body
        let trumpQuote = quoteLibrary.lookup(quote: quote)

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.setQuotePlaying(quote: trumpQuote)
        }
 */
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        let quote = response.notification.request.content.body
        let trumpQuote = quoteLibrary.lookup(quote: quote)

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.setQuotePlaying(quote: trumpQuote)
        }
    }
}

