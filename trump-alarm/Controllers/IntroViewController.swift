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
                (success, pollHoursString) in
                print("Parsing user polling hours: \(pollHoursString ?? "N/A")")
                let pollHours = PollingAPIResponse(response: pollHoursString)
                print("open: \(pollHours.pollsOpenDate.standardPrint() ?? "N/A")")
                print("close: \(pollHours.pollsCloseDate.standardPrint() ?? "N/A")")
                self.navigateToCountdown(userPollingHours: pollHours)
            })
        }, onFailure: {
            (error: Error) in
                self.navigateToCountdown(userPollingHours: PollingAPIResponse())
        })
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let copy = "Need a reminder of why you should wake up and vote for Hillary on November 8th? The Trump Alarm spews frightening Trump sounds bites every hour on the hour from the time the polls open to the time polls close on election day. The only way to turn off the most annoying, offensive alarm clock ever is by voting. Download and Make America Wake Up and Vote Again!"
        if let url = NSURL(string: "http://www.trumpalarm.com") {
            let activityVC = UIActivityViewController(activityItems: [copy as String, url], applicationActivities: nil)
            present(activityVC, animated: true, completion: nil)
        }
    }
    
    
    func navigateToCountdown(userPollingHours: PollingAPIResponse) {
        TrumpAlarmUserDefaults.hasSeenIntro = true
        TrumpAlarmUserDefaults.userPollingHours = userPollingHours

        notificationManager.setupAppropriatePolling()
        
        self.dismiss(animated: true, completion: nil)
    }

}
