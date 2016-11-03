//
//  QuotePlayViewController.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/31/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit
import SnapKit

class QuotePlayViewController: UIViewController {

    var trumpQuote: TrumpQuote?

    @IBOutlet weak var quoteTextLabel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        quoteTextLabel.text = trumpQuote?.content

        let fixedWidth = quoteTextLabel.frame.size.width
        quoteTextLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = quoteTextLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))

        quoteTextLabel.snp.makeConstraints {
            (make) -> Void in
            make.height.equalTo(newSize.height)
        }

    }

    @IBAction func shareClicked(_ sender: Any) {
        if let audioFile = trumpQuote?.audioFile {
            
            let truncAudio = audioFile.replacingOccurrences(of: ".wav", with: "")
            if let localPath = Bundle.main.path(forResource: truncAudio, ofType: "wav") {
            let quoteURL = NSURL(fileURLWithPath: localPath)
            let avc = UIActivityViewController(activityItems: [quoteURL, TAAudioShareItemSource()] as [AnyObject], applicationActivities: nil)
            present(avc, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
