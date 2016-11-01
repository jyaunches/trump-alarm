//
//  CameraViewController.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/26/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit
import QuartzCore

class PostVotingController: UIViewController {
   
    @IBOutlet weak var votingImage: UIImageView!
    var photoManager = PhotoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photo = photoManager.getImage() {
            votingImage.image = photo
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)

        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}
