//
//  ThanksForVotingViewController.swift
//  trump-alarm
//
//  Created by Stephanie Guevara on 11/2/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class ThanksForVotingViewController: UIViewController {
    
    let countdownManager = CountdownManager()
 
    @IBOutlet var yearsLabel: UILabel!
    @IBOutlet var monthsLabel: UILabel!
    @IBOutlet var daysLabel: UILabel!
    
    var nextElectionDate: Date!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let electionComponent = NSDateComponents()
        electionComponent.year = 2020
        electionComponent.month = 11
        electionComponent.day = 4
        
        nextElectionDate = Calendar.current.date(from:electionComponent as DateComponents)
        
        let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(onTick(timer:)), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func onTick(timer: Timer) {
        let currentDate = Date()
        let y = nextElectionDate.years(from: currentDate)
        let m = (nextElectionDate - y.years).months(from: currentDate)
        let d = (nextElectionDate - y.years - m.months).days(from: currentDate) + 1

        daysLabel.text = "\(d)"
        monthsLabel.text = "\(m)"
        yearsLabel.text = "\(y)"
    }
    
}
