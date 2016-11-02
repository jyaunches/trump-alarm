//
//  Constants.swift
//  trump-alarm
//
//  Created by Stephanie Guevara on 10/29/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

struct Environment {
    
    struct Path {
        static let googleCivicInfoAPIKeyName = "key"
        static let googleCivicInfoAPIPath = "https://www.googleapis.com/civicinfo/v2/voterinfo"
    }
    
    struct Styling {
        static let trumpGold = UIColor(red: 228.0/255.0, green: 201.0/255.0, blue: 55.0/255.0, alpha: 1.0)
        static let trumpRed = UIColor(red: 165.0/255.0, green: 30.0/255.0, blue: 35.0/255.0, alpha: 1.0)
    }
    
    struct Share {
        static let fbCopy = "Need a reminder of why you should wake up and vote for Hillary on November 8th? The Trump Alarm spews frightening Trump sounds bites every hour on the hour from the time the polls open to the time polls close on Election Day. The only way to turn off the most annoying, offensive and effective alarm clock ever is by voting. Download and Make America Wake Up and Vote Again:"
   
        static let defaultCopy = "default"

    }
    
    
}
