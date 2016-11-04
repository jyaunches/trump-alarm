//
//  QuotePlayViewController.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/31/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation
import Photos
import AssetsLibrary

class QuotePlayViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var trumpFaceImage: TrumpFace!
    var trumpQuote: TrumpQuote?
    var quotePlayer: QuotePlayer = QuotePlayer()
    var quoteLibrary = TrumpQuoteLibrary()
    var fixedWidth: CGFloat = 310
    var photoManager = PhotoManager()
    
    @IBOutlet weak var trumpNameLabel: UILabel!
    @IBOutlet weak var quoteTextLabel: UITextView!
    
    @IBOutlet weak var iVotedButton: BorderedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutQuoteLabel()
        fixedWidth = quoteTextLabel.frame.size.width
        
        trumpFaceImage.setup(onClick: {
            self.trumpQuote = self.quoteLibrary.getRandomQuote(idPrefix: "in-app")
            self.layoutQuoteLabel()
            self.playQuote()
        })

        if TrumpAlarmUserDefaults.hasVoted {
            iVotedButton.isHidden = true
        }
    }

    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        quotePlayer.stop()
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
            self.navigationController?.pushViewController(postVC, animated: true)

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


    @IBAction func votedClicked(_ sender: Any) {
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
    
    func layoutQuoteLabel() {
        quoteTextLabel.text = trumpQuote?.content
        
        let sizingLabel = UILabel()
        sizingLabel.font = quoteTextLabel.font
        sizingLabel.text = quoteTextLabel.text
        sizingLabel.frame = quoteTextLabel.frame
        
        
        quoteTextLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = quoteTextLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        self.quoteTextLabel.snp.makeConstraints {
            (make) -> Void in
            make.height.equalTo(newSize.height)
        }
        
        self.trumpNameLabel.snp.makeConstraints {
            (make) -> Void in
            make.top.equalTo(self.quoteTextLabel.snp.bottom).offset(8)
        }
        
        self.quoteTextLabel.setNeedsDisplay()
        self.trumpNameLabel.setNeedsDisplay()
        self.view.setNeedsLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playQuote()
    }
    
    func playQuote() {
        if let quote = trumpQuote {
            quotePlayer.playQuoteFile(trumpQuote: quote)
        }
    }

    @IBAction func shareClicked(_ sender: Any) {
        if let trumpQuote = trumpQuote {
            let avc = UIActivityViewController(activityItems: [TAAudioShareURLItemSource(quote: trumpQuote), TAAudioShareItemSource(quote: trumpQuote)] as [AnyObject], applicationActivities: nil)
            present(avc, animated: true, completion: nil)        
        }
    }

}
