//
//  CameraViewController.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/26/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class PostVotingController: UIViewController {

    @IBOutlet weak var iVotedLabel: UILabel!
    @IBOutlet weak var votingImage: UIImageView!
    var photoManager = PhotoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photo = photoManager.getImage() {
            votingImage.image = photo
        }
        
        iVotedLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
