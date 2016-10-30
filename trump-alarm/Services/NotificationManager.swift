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

    func requestNotificationPermission(onAgree: (() -> Void)?) {
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                onAgree?()
            }
        }
    }
    
    func schedule(filename: String, interval: TimeInterval, body: String, identifier: String)  {
        let content = UNMutableNotificationContent()
        content.title = "Wake up and Vote"
        content.body = body
        content.sound = UNNotificationSound(named: filename)
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier:identifier, content: content, trigger: trigger)

        center.add(request){(error) in

            if (error != nil){
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

