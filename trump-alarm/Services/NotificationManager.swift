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
                TrumpQuote(content: SoundBiteContent.grabEm, audioFile: "grab-em.wav", identifier: "nasty-woman"),
                TrumpQuote(content: SoundBiteContent.datingIvanka, audioFile: "dating-Ivanka.wav", identifier: "bomb-the-shit"),
                TrumpQuote(content: SoundBiteContent.droppingToKnees, audioFile: "dropping-to-your-knees.wav", identifier: "creeping-miss-teen"),
                TrumpQuote(content: SoundBiteContent.muslimShutdown, audioFile: "muslim-shutdown.wav", identifier: "foo123"),
                TrumpQuote(content: SoundBiteContent.meganKelly, audioFile: "megan-kelly-blood.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.nastyWoman, audioFile: "nasty_woman.wav", identifier: "foo345"),
                TrumpQuote(content: SoundBiteContent.fifthAve, audioFile: "I-could-shoot-somebody.wav", identifier: "foo678"),
                TrumpQuote(content: SoundBiteContent.bombTheShit, audioFile: "bomb-the-shit.wav", identifier: "foo567"),
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

    func setupPollingDay(pollingHours: PollingAPIResponse) {
        let pollingDayQuotes = [
                TrumpQuote(content: SoundBiteContent.waterboarding, audioFile: "waterboarding.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.handSize, audioFile: "hand-size.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.obamaCofoundedIsis, audioFile: "obama-clinton-co-founded-ISIS.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.fuckHerSheWasMarried, audioFile: "try-and-fuck-her-she-was-married.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.mccainNotAHero, audioFile: "not-a-war-hero.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.secondAmendment, audioFile: "second-ammendment.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.takeTheirGuns, audioFile: "take-their-guns-away.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.buildAWall, audioFile: "build-a-wall.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.noPuppet, audioFile: "you're-the-puppet.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.nucs, audioFile: "won't-rule-out-nuclear-weapons.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.relationshipWithTheBlacks, audioFile: "great-relationship-with-the-blacks.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.teenCreeping, audioFile: "creeping-miss-teen.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.theyreRapists, audioFile: "they're-rapist.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.carryOutInAStretcher, audioFile: "carried-out-in-a-stretcher.wav", identifier: "foo234"),
                /*
                TrumpQuote(content: SoundBiteContent.obamaPositiveImactOnThugs, audioFile: "bomb-the-shit.wav", identifier: "foo234"),
                TrumpQuote(content: SoundBiteContent.iWontLoseAPenny, audioFile: "bomb-the-shit.wav", identifier: "foo234")
                */

        ]

        requestNotificationPermission(onAgree: {
            for (index, interval) in Date.intervalsOnElectionDay(electionDayStart: pollingHours.pollsOpenDate, electionDayEnd: pollingHours.pollsCloseDate).enumerated() {
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

