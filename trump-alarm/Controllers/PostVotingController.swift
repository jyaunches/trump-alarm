//
//  CameraViewController.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/26/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit
import QuartzCore
import Photos

class PostVotingController: UIViewController {
    @IBOutlet var snapshotView: UIView!

    @IBOutlet weak var votingImage: UIImageView!

    var cachedImage: UIImage?
    var photoManager = PhotoManager()
    var appDelegate = AppDelegate()

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let cachedImage = cachedImage {
            votingImage.image = cachedImage
        } else if let photo = photoManager.getImage() {
            votingImage.image = photo
        }
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func shareButtonTapped(_ sender: Any) {
        if let votingImage = PhotoManager().getImage() {
            let avc = UIActivityViewController(activityItems: [votingImage, TAIVotedItemSource(), TAShareURLItemSource()] as [AnyObject], applicationActivities: nil)
            present(avc, animated: true, completion: nil)
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        let snapshot = takeSnapshot()
        
        let status = PHPhotoLibrary.authorizationStatus()
        if status == PHAuthorizationStatus.authorized {
            UIImageWriteToSavedPhotosAlbum(snapshot, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        } else if status == PHAuthorizationStatus.denied {
            let alert = UIAlertController(title: "Cannot access your photos", message: "To save your photo, we'll need access to your library. Please return to the app's settings to change permissions.", preferredStyle: .alert)
            let nope = UIAlertAction(title: "No thanks", style: .cancel , handler: nil)
            let openSettings = UIAlertAction(title: "Go to settings", style: .default, handler: { (_) in
                if let url = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            })
            alert.addAction(nope)
            alert.addAction(openSettings)
            self.present(alert, animated: true, completion: nil)
        } else if status == PHAuthorizationStatus.notDetermined {
            PHPhotoLibrary.requestAuthorization({ (_) in
                
            })
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(snapshotView.bounds.size, false, UIScreen.main.scale)

        view.drawHierarchy(in: snapshotView.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}
