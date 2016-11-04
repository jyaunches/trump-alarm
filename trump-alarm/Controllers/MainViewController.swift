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
    @IBOutlet weak var trumpFaceImage: TrumpFace!
    @IBOutlet weak var untilPollsLabel: UILabel!
    @IBOutlet weak var votingButton: BorderedButton!

    var countdownEndDate = Date()
    var photoManager = PhotoManager()
    var countdownManager = CountdownManager()
    var quoteLibrary = TrumpQuoteLibrary()
    let storyboardDirector = StoryboardDirector()

    let currentDate = Date()
    let countdownPollsOpen = TrumpAlarmUserDefaults.userPollingHours.pollsOpenDate
    let countdownPollsClose = TrumpAlarmUserDefaults.userPollingHours.pollsCloseDate

    var cachedVotingImage: UIImage?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if TrumpAlarmUserDefaults.hasVoted {
            votingButton.setTitle("VOTING EVIDENCE", for: .normal)
            votingButton.setTitleColor(UIColor.white, for: .normal)
            votingButton.backgroundColor = UIColor.clear
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCachedVotingImage()

        if !TrumpAlarmUserDefaults.hasSeenIntro {
            let introVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntroViewController")
            self.present(introVC, animated: false, completion: nil)
        }

        navigationItem.setHidesBackButton(true, animated: false)
        trumpFaceImage.setup(onClick: {
            let quote = self.quoteLibrary.getRandomQuote(idPrefix: "in-app")
            if let quoteVC = self.storyboardDirector.buildQuotePlaying(quote: quote) {
                self.navigationController?.pushViewController(quoteVC, animated: true)
            }
        })

        let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(onTick(timer:)), userInfo: nil, repeats: true)
        timer.fire()
    }

    func onTick(timer: Timer) {

        if currentDate < countdownPollsOpen {
            countdownEndDate = countdownPollsOpen
            untilPollsLabel.text = "UNTIL POLLS OPEN"
        } else if currentDate < countdownPollsClose {
            countdownEndDate = countdownPollsClose
            untilPollsLabel.text = "UNTIL POLLS CLOSE"
        }

        let remainingTime = countdownEndDate.timeIntervalSinceNow
        let a = String(format: "%02d", (Int(remainingTime) / (60 * 60)))
        let b = String(format: "%02d", (Int(remainingTime) % (60 * 60) / 60))
        let c = String(format: "%02d", (Int(remainingTime) % 60))
        hoursValueLabel.text = a
        minutesValueLabel.text = b
        secondsValueLabel.text = c
    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let tempImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoManager.writeImage(image: tempImage)
        }
        NotificationManager.sharedInstance.cancelFutureNotififications()

        TrumpAlarmUserDefaults.hasVoted = true
        pushPostVoting()
        picker.dismiss(animated: true)
    }

    func pushPostVoting() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
        let postVC = appDelegate.storyboard.instantiateViewController(withIdentifier: "PostVotingController") as? PostVotingController {
            postVC.cachedImage = cachedVotingImage
            self.navigationController?.pushViewController(postVC, animated: true)

        }
    }

    @IBAction func readyToVoteClicked(_ sender: Any) {
        if TrumpAlarmUserDefaults.hasVoted {
            pushPostVoting()
        } else {
            let alertController = UIAlertController(title: "Did you really vote?", message: "Prove it! To silence this awful Trump noise, take a picture of yourself after voting.)", preferredStyle: UIAlertControllerStyle.alert)

            let DestructiveAction = UIAlertAction(title: "Cancel", style: .cancel) {
                (result: UIAlertAction) -> Void in
                alertController.dismiss(animated: true, completion: nil)
            }
            let okAction = UIAlertAction(title: "I JUST VOTED", style: .default) {
                (result: UIAlertAction) -> Void in
                self.openCamera()
            }
            alertController.addAction(DestructiveAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
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

    @IBAction func shareButtonTapped(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [TAAppShareItemSource(), TAShareURLItemSource()], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }

    func loadCachedVotingImage() {
        DispatchQueue.global(qos: .background).async {
            let photo = self.photoManager.getImage()

            DispatchQueue.main.async {
                self.cachedVotingImage = photo
            }
        }
    }
}
