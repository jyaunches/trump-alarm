//
//  AppDelegate.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/26/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let storyboardDirector = StoryboardDirector()
    
    
    func setThanksForVotingAsRoot() {
        self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "ThanksForVotingVC")
        self.window?.makeKeyAndVisible()
    }
    
    func setCountdownAsRoot() {
        let mainCountDown = storyboard.instantiateViewController(withIdentifier: "MainCountDownVC")
        setMainNVCWith(stack: [mainCountDown])
    }

    func setQuotePlaying(quote: TrumpQuote) {
        if let quoteVC = storyboardDirector.buildQuotePlaying(quote: quote) {
            setMainNVCWith(stack: [quoteVC])
        }
    }

    func setMainNVCWith(stack: [UIViewController]) {
        if let rootNav = storyboard.instantiateViewController(withIdentifier: "IntroNVC") as? UINavigationController {
            rootNav.viewControllers = stack
            self.window?.rootViewController = rootNav
            self.window?.makeKeyAndVisible()
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {                
        if Date.endOfelectionDay <= Date() {
            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "ThanksForVotingVC")
            self.window?.makeKeyAndVisible()
        } else if !TrumpAlarmUserDefaults.hasSeenIntro {
            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "IntroNVC")
            self.window?.makeKeyAndVisible()
        } else if TrumpAlarmUserDefaults.hasVoted {
            if Date() < Date.midnightOfelectionDay {
                setCountdownAsRoot()
            } else {
                setThanksForVotingAsRoot()
            }
        } else {
            if let mainCountDown = storyboardDirector.buildMainCountdown() {
                setMainNVCWith(stack: [mainCountDown])
            }
        }
        return true
    }
    
    
    
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound], completionHandler: {(granted, error) in
            print("stuff happening")
        })
    }
    

}

