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


        cachedVotingImage = photoManager.getImage()


        if !TrumpAlarmUserDefaults.hasSeenIntro {
            let introVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntroViewController")
            self.present(introVC, animated: false, completion: nil)

        }

        navigationItem.setHidesBackButton(true, animated: false)
        trumpFaceImage.setup()

        let countdownPollsOpen = TrumpAlarmUserDefaults.userPollingHours.pollsOpenDate
        let countdownPollsClose = TrumpAlarmUserDefaults.userPollingHours.pollsCloseDate

        //countdownEndDate starts at today's date
        if countdownEndDate < countdownPollsOpen {
            countdownEndDate = countdownPollsOpen
            untilPollsLabel.text = "UNTIL POLLS OPEN"
        } else if countdownEndDate < countdownPollsClose {
            countdownEndDate = countdownPollsClose
            untilPollsLabel.text = "UNTIL POLLS CLOSE"
        }

        let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(onTick(timer:)), userInfo: nil, repeats: true)
        timer.fire()
    }

    func onTick(timer: Timer) {
        let remainingTime = countdownEndDate.timeIntervalSinceNow
        let a = Int(remainingTime) / (60 * 60)
        let b = Int(remainingTime) % (60 * 60) / 60
        let c = Int(remainingTime) % 60
        hoursValueLabel.text = "\(a)"
        minutesValueLabel.text = "\(b)"
        secondsValueLabel.text = "\(c)"
    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {

        if let tempImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoManager.writeImage(image: tempImage)
        }

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
            let alertController = UIAlertController(title: "Are you at you're polling station?", message: "You must must get photo evidence of yourself voting to silence these awful alarms! (while respecting your local polling places rules around photography.)", preferredStyle: UIAlertControllerStyle.alert)

            let DestructiveAction = UIAlertAction(title: "Cancel", style: .cancel) {
                (result: UIAlertAction) -> Void in
                alertController.dismiss(animated: true, completion: nil)
            }
            let okAction = UIAlertAction(title: "I'M VOTING", style: .default) {
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
        let copy = "Need a reminder of why you should wake up and vote for Hillary on November 8th? The Trump Alarm spews frightening Trump sounds bites every hour on the hour from the time the polls open to the time polls close on election day. The only way to turn off the most annoying, offensive alarm clock ever is by voting. Download and Make America Wake Up and Vote Again!"
        if let url = NSURL(string: "http://www.trumpalarm.com") {
            let activityVC = UIActivityViewController(activityItems: [TAAppShareItemSource(), url], applicationActivities: nil)
            present(activityVC, animated: true, completion: nil)
        }
    }
}
