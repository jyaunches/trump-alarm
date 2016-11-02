//
//  TrumpAlarmNotification.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 11/1/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import Foundation
import UserNotifications

class TrumpAlarmNotification : NSObject {
    static func build(quote: TrumpQuote, interval: TimeInterval) -> UNNotificationRequest {
    
        let content = UNMutableNotificationContent()
        content.title = "Wake up and Vote"
        content.body = quote.content
        content.sound = UNNotificationSound(named: quote.audioFile)
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: interval, repeats: false)
        return UNNotificationRequest(identifier: quote.identifier, content: content, trigger: trigger)
    }
}
