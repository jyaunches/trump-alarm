//
//  borderedButton.swift
//  trump-alarm
//
//  Created by Sarah Dulat on 10/30/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedButton : UIButton {
	
	override func awakeFromNib() {
		self.layer.borderColor = Environment.Styling.trumpGold.cgColor
	}
}
