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

        // Do any additional setup after loading the view.
    }

    @IBAction func gotItClicked(_ sender: Any) {
        locationManager.requestPermission(onSuccess: {
            (location: String) in
            self.civicInfoInteractor.getPollInfo(params: ["address": location, "fields": "pollingLocations/pollingHours"], completion: {
                (success, pollHours) in
                TrumpAlarmUserDefaults.userPollingHours = PollingAPIResponse(response: pollHours)
                //self.countdownManager.storePollingHours(pollHours: pollHours!)
                if !success {

                    let pollErrorAlert = UIAlertController.init(title: "Error",
                            message: "Failed to retrieve your local poll hours",
                            preferredStyle: .alert)
                    pollErrorAlert.show(self, sender: nil)
                }
            })
        },
                onFailure: {
                    (error: Error) in
                    let locationError = UIAlertController.init(title: "Error",
                            message: "Failed to get retrieve your location",
                            preferredStyle: .alert)
                    locationError.show(self, sender: nil)
                })
    }

}
