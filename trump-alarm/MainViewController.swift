//
//  MainViewController.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/26/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var hoursValueLabel: UILabel!
    @IBOutlet weak var minutesValueLabel: UILabel!
    @IBOutlet weak var secondsValueLabel: UILabel!
    
    var countdownEndDate = Date()
    var photoManager = PhotoManager()
    var countdownManager = CountdownManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        countdownEndDate = TrumpAlarmUserDefaults.userPollingHours.pollsOpenDate
 
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTick(timer:)), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func onTick(timer: Timer) {
        let remainingTime = countdownEndDate.timeIntervalSinceNow
        let a = Int(remainingTime)/(60*60)
        let b = Int(remainingTime)%(60*60)/60
        let c = Int(remainingTime)%60
        hoursValueLabel.text = "\(a)"
        minutesValueLabel.text = "\(b)"
        secondsValueLabel.text = "\(c)"
    }
            
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        if let tempImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            UIImageWriteToSavedPhotosAlbum(tempImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            
            photoManager.writeImage(image: tempImage)
        }
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            TrumpAlarmUserDefaults.hasVoted = true
            appDelegate.setPostVotingAsRoot()
        }
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction func readyToVoteClicked(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Are you at you're polling station?", message: "You must must get photo evidence of yourself voting to silence these awful alarms! (while respecting your local polling places rules around photography.)", preferredStyle: UIAlertControllerStyle.alert)
        
        let DestructiveAction = UIAlertAction(title: "Cancel", style: .cancel) { (result : UIAlertAction) -> Void in
            alertController.dismiss(animated: true, completion: nil)
        }
        let okAction = UIAlertAction(title: "I'M VOTING", style: .default) { (result : UIAlertAction) -> Void in
            self.openCamera()
        }
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}
