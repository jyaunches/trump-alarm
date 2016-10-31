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
}
