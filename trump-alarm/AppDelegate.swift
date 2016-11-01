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
    
    func setPostVotingAsRoot() {
        self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "PostVotingController")
        self.window?.makeKeyAndVisible()
    }
    
    func setQuotePlaying(quote: TrumpQuote) {
        if let quoteVC = storyboardDirector.buildQuotePlaying(quote: quote) {
            setIntroNVCWith(root: quoteVC)
        }
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {                
        if Date.endOfelectionDay <= Date() {
            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "ThanksForVotingVC")
            self.window?.makeKeyAndVisible()
        } else if !TrumpAlarmUserDefaults.hasSeenIntro {
            NotificationManager.sharedInstance.setupPrePolling(pollingDate: Date.midnightOfelectionDay)
            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "IntroNVC")
            self.window?.makeKeyAndVisible()
        } else if TrumpAlarmUserDefaults.hasVoted {
            setPostVotingAsRoot()
        } else {
            if let mainCountDown = storyboardDirector.buildMainCountdown() {
                setIntroNVCWith(root: mainCountDown)
            }
        }
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound], completionHandler: {(granted, error) in
            print("stuff happening")
        })
        return true
    }
    
    func setIntroNVCWith(root: UIViewController) {
        if let rootNav = storyboard.instantiateViewController(withIdentifier: "IntroNVC") as? UINavigationController {
            rootNav.viewControllers = [root]
            self.window?.rootViewController = rootNav
            self.window?.makeKeyAndVisible()
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

