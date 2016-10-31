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

    override init() {
        super.init()

        center.delegate = self
    }

    func setupPrePolling(pollingDate: Date) {
        let prePollsQuotes = [
            TrumpQuote(content: "Such a nasty woman.", audioFile: "nasty_woman.wav", identifier: "nasty-woman"),
                TrumpQuote(content: "Bomb the shit out of em.", audioFile: "bomb-the-shit.wav", identifier: "bomb-the-shit"),
                TrumpQuote(content: "Creeping miss teen.", audioFile: "creeping-miss-teen.wav", identifier: "creeping-miss-teen"),
                TrumpQuote(content: "Such a nasty woman.", audioFile: "nasty_woman.wav", identifier: "foo123"),
                TrumpQuote(content: "Bomb the shit out of em.", audioFile: "bomb-the-shit.wav", identifier: "foo234"),
                TrumpQuote(content: "Creeping miss teen.", audioFile: "creeping-miss-teen.wav", identifier: "foo345"),
                TrumpQuote(content: "Such a nasty woman.", audioFile: "bomb-the-shit.wav", identifier: "foo678"),
                TrumpQuote(content: "Bomb the shit out of em.", audioFile: "bomb-the-shit.wav", identifier: "foo567"),
        ]

        requestNotificationPermission(onAgree: {
            let intervals: [TimeInterval] = Date.intervalsUntilElectionDay()
            
            for (index, interval) in intervals.enumerated() {
                let actualAlarmDate = Date(timeIntervalSinceReferenceDate: Date().timeIntervalSinceReferenceDate + interval)
                print("Scheduling alarm for: \(actualAlarmDate.standardPrint()))")
                let quote = prePollsQuotes[index]
                self.schedule(quote: quote, interval: interval)
            }
        })
    }

    func setupPollingDay() {
        let pollingDayQuotes = [
                TrumpQuote(content: "Creeping miss teen.", audioFile: "creeping-miss-teen.wav", identifier: "foo234"),
                TrumpQuote(content: "Such a nasty woman.", audioFile: "nasty_woman.wav", identifier: "foo234"),
                TrumpQuote(content: "Bomb the shit out of em.", audioFile: "bomb-the-shit.wav", identifier: "foo234"),
                TrumpQuote(content: "Creeping miss teen.", audioFile: "creeping-miss-teen.wav", identifier: "foo234"),
                TrumpQuote(content: "Creeping miss teen.", audioFile: "creeping-miss-teen.wav", identifier: "foo234"),
                TrumpQuote(content: "Such a nasty woman.", audioFile: "nasty_woman.wav", identifier: "foo234"),
                TrumpQuote(content: "Bomb the shit out of em.", audioFile: "bomb-the-shit.wav", identifier: "foo234")
        ]

        requestNotificationPermission(onAgree: {
            for (index, interval) in Date.intervalsOnElectionDay().enumerated() {
                let quote = pollingDayQuotes[index]
                self.schedule(quote: quote, interval: interval)
            }
        })
    }

    func requestNotificationPermission(onAgree: (() -> Void)?) {
        center.requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
            if granted {
                onAgree?()
            }
        }
    }

    func schedule(quote: TrumpQuote, interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Wake up and Vote"
        content.body = quote.content
        content.sound = UNNotificationSound(named: quote.audioFile)
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: quote.identifier, content: content, trigger: trigger)

        center.add(request) {
            (error) in

            if (error != nil) {
                print("Error scheduling notification: \(error)")
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
//        self.schedule(request: self.requests[1])
        print("Will present")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
//        self.schedule(request: self.requests[1])
        print("Tapped in notification")
    }

}

