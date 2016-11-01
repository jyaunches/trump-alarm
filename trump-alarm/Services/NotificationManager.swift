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
        schedule(quote: quoteLibrary.getRandomQuote(), interval: 1)
        schedule(quote: quoteLibrary.getRandomQuote(), interval: 5)
        schedule(quote: quoteLibrary.getRandomQuote(), interval: 10)
        schedule(quote: quoteLibrary.getRandomQuote(), interval: 15)
    }
    
    func setupPrePolling(pollingDate: Date) {
        let prePollsQuotes = [
            TrumpQuote(content: SoundBiteContent.grabEm, audioFile: "grab-em.wav", identifier: "pre-polling-nasty-woman"),
            TrumpQuote(content: SoundBiteContent.datingIvanka, audioFile: "dating-Ivanka.wav", identifier: "pre-polling-bomb-the-shit"),
            TrumpQuote(content: SoundBiteContent.droppingToKnees, audioFile: "dropping-to-your-knees.wav", identifier: "pre-polling-creeping-miss-teen"),
            TrumpQuote(content: SoundBiteContent.muslimShutdown, audioFile: "muslim-shutdown.wav", identifier: "pre-polling-muslim-shutdown"),
            TrumpQuote(content: SoundBiteContent.meganKelly, audioFile: "megan-kelly-blood.wav", identifier: "pre-polling-megan-kelly-blood"),
            TrumpQuote(content: SoundBiteContent.nastyWoman, audioFile: "nasty_woman.wav", identifier: "pre-polling-nasty_woman"),
            TrumpQuote(content: SoundBiteContent.fifthAve, audioFile: "I-could-shoot-somebody.wav", identifier: "pre-polling-I-could-shoot-somebody"),
            TrumpQuote(content: SoundBiteContent.bombTheShit, audioFile: "bomb-the-shit.wav", identifier: "pre-polling-bomb-the-shit"),
            TrumpQuote(content: SoundBiteContent.waterboarding, audioFile: "waterboarding.wav", identifier: "pre-polling-waterboarding")
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
            TrumpQuote(content: SoundBiteContent.waterboarding, audioFile: "waterboarding.wav", identifier: "polling-day-waterboarding"),
            TrumpQuote(content: SoundBiteContent.handSize, audioFile: "hand-size.wav", identifier: "polling-day-hand-size"),
            TrumpQuote(content: SoundBiteContent.obamaCofoundedIsis, audioFile: "obama-clinton-co-founded-ISIS.wav", identifier: "polling-day-obama-clinton-co-founded-ISIS"),
            TrumpQuote(content: SoundBiteContent.fuckHerSheWasMarried, audioFile: "try-and-fuck-her-she-was-married.wav", identifier: "polling-day-try-and-fuck-her-she-was-married"),
            TrumpQuote(content: SoundBiteContent.mccainNotAHero, audioFile: "not-a-war-hero.wav", identifier: "polling-day-not-a-war-hero"),
            TrumpQuote(content: SoundBiteContent.secondAmendment, audioFile: "second-ammendment.wav", identifier: "polling-day-second-ammendment"),
            TrumpQuote(content: SoundBiteContent.takeTheirGuns, audioFile: "take-their-guns-away.wav", identifier: "polling-day-take-their-guns-away"),
            TrumpQuote(content: SoundBiteContent.buildAWall, audioFile: "build-a-wall.wav", identifier: "polling-day-build-a-wall"),
            TrumpQuote(content: SoundBiteContent.noPuppet, audioFile: "you're-the-puppet.wav", identifier: "polling-day-you're-the-puppet"),
            TrumpQuote(content: SoundBiteContent.nucs, audioFile: "won't-rule-out-nuclear-weapons.wav", identifier: "polling-day-won't-rule-out-nuclear-weapons"),
            TrumpQuote(content: SoundBiteContent.relationshipWithTheBlacks, audioFile: "great-relationship-with-the-blacks.wav", identifier: "polling-day-great-relationship-with-the-blacks"),
            TrumpQuote(content: SoundBiteContent.teenCreeping, audioFile: "creeping-miss-teen.wav", identifier: "polling-day-creeping-miss-teen"),
            TrumpQuote(content: SoundBiteContent.theyreRapists, audioFile: "they're-rapist.wav", identifier: "polling-day-they're-rapist"),
            TrumpQuote(content: SoundBiteContent.carryOutInAStretcher, audioFile: "carried-out-in-a-stretcher.wav", identifier: "polling-day-   carried-out-in-a-stretcher"),
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
        
        completionHandler([.alert,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        
        let quote = response.notification.request.content.body
        let trumpQuote = quoteLibrary.lookup(quote: quote)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.setQuotePlaying(quote: trumpQuote)
        }
    }
}

