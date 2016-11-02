//
//  IntroViewController.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/31/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    var civicInfoInteractor = GoogleCivicInformationInteractor()
    var locationManager = LocationManager()
    var appDelegate = AppDelegate()
    var notificationManager = NotificationManager()

    override func viewWillAppear(_ animated: Bool) {

        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
        // Do any additional setup after loading the view.
    }

    @IBAction func gotItClicked(_ sender: Any) {
        locationManager.requestPermission(onSuccess: {
            (location: String) in
            self.civicInfoInteractor.getPollInfo(params: ["address": location, "fields": "pollingLocations/pollingHours"], completion: {
                (success, pollHours) in                
                self.navigateToCountdown(userPollingHours: PollingAPIResponse(response: pollHours))
                })
                self.appDelegate.requestAuthorization()
                self.notificationManager.requestNotificationPermission {
                    NotificationManager.sharedInstance.setupPrePolling(pollingDate: Date.midnightOfelectionDay)
                }
            self.dismiss(animated: true, completion: nil)
            
        }, onFailure: {
            (error: Error) in
                self.navigateToCountdown(userPollingHours: PollingAPIResponse())
            self.appDelegate.requestAuthorization()
            self.notificationManager.requestNotificationPermission {
                NotificationManager.sharedInstance.setupPrePolling(pollingDate: Date.midnightOfelectionDay)
            }
            self.dismiss(animated: true, completion: nil)
        })


    }
    
    func navigateToCountdown(userPollingHours: PollingAPIResponse) {
        TrumpAlarmUserDefaults.hasSeenIntro = true
        TrumpAlarmUserDefaults.userPollingHours = userPollingHours
//        self.performSegue(withIdentifier: "ShowCountDownFromIntroSegue", sender: self)                
    }

}
