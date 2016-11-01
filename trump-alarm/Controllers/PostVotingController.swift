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
    
    
    func overlayImageOnScreenshot() -> UIImage {
        
        let imageSize : CGSize = UIScreen.main.bounds.size
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
 
        let context = UIGraphicsGetCurrentContext()
        
        for window in UIApplication.shared.windows {
            if window.responds(to: #selector(getter: UIWindow.screen)) || window.screen == UIScreen.main {
                context?.saveGState()
                context?.ctm.translatedBy(x: window.center.x, y: window.center.y)
                context?.ctm.concatenating(window.transform)
                
                context?.ctm.translatedBy(x: window.bounds.size.width * window.layer.anchorPoint.x,
                                         y: window.bounds.size.height * window.layer.anchorPoint.y)
                
                window.layer.render(in: context!)
                
                context?.restoreGState()
            }
        }
        

    let image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image!;
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
