//
//  TrumpFace.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/31/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class TrumpFace: UIImageView {

    func setup() {
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(self.faceTapped(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    func faceTapped(_ sender: UITapGestureRecognizer) {
        NotificationManager.sharedInstance.spew()
    }

}
