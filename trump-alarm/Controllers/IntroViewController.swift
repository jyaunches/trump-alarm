//
//  IntroViewController.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/31/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    var civicInfoInteractor = GoogleCivicInformationInteractor()
    var locationManager = LocationManager()

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
        }, onFailure: {
            (error: Error) in
                self.navigateToCountdown(userPollingHours: PollingAPIResponse())
        })
    }
    
    
    
    func navigateToCountdown(userPollingHours: PollingAPIResponse) {
        TrumpAlarmUserDefaults.hasSeenIntro = true
        TrumpAlarmUserDefaults.userPollingHours = userPollingHours
        self.performSegue(withIdentifier: "ShowCountDownFromIntroSegue", sender: self)                
    }

}
