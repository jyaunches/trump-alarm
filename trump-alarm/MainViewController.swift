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

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var imagePicked: UIImageView!
    
    var countdownStartTime : TimeInterval?
    
    var photoManager = PhotoManager()
    var locationManager = LocationManager()
    var countdownManager = CountdownManager()
    var civicInfoInteractor = GoogleCivicInformationInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
             
        self.countdownStartTime = self.countdownManager.getCountdownData(pollHours: "8 am - 8 pm")

        //Commented out the below to avoid using the API call since I cannot run app on device. Uncomment to make call
        //self.startupApp()
        
    }
    
    private func startupApp() {
        locationManager.requestPermission(onSuccess: {
            (location: String) in
                        self.civicInfoInteractor.getPollInfo(params:["address": location, "fields": "pollingLocations/pollingHours"], completion: { (success, pollHours) in
                self.countdownStartTime = self.countdownManager.getCountdownData(pollHours: pollHours!)
                if !success {
                    
                    let pollErrorAlert = UIAlertController.init(title: "Error",
                                                                message: "Failed to retrieve your local poll hours",
                                                                preferredStyle: .alert)
                    pollErrorAlert.show(self, sender: nil)                }
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
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        if let tempImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            UIImageWriteToSavedPhotosAlbum(tempImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            
            photoManager.writeImage(image: tempImage)
        }
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
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
    
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}
