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

    @IBOutlet weak var trumpFaceImage: TrumpFace!
    var trumpQuote: TrumpQuote?
    var quotePlayer: QuotePlayer = QuotePlayer()
    var quoteLibrary = TrumpQuoteLibrary()
    var fixedWidth: CGFloat = 310
    
    @IBOutlet weak var trumpNameLabel: UILabel!
    @IBOutlet weak var quoteTextLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutQuoteLabel()
        fixedWidth = quoteTextLabel.frame.size.width
        
        trumpFaceImage.setup(onClick: {
            self.trumpQuote = self.quoteLibrary.getRandomQuote(idPrefix: "in-app")
            self.layoutQuoteLabel()
            self.playQuote()
        })
    }

    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        quotePlayer.stop()
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
        if let url = trumpQuote?.audioFileURL {
            let avc = UIActivityViewController(activityItems: [url, TAAudioShareItemSource()] as [AnyObject], applicationActivities: nil)
            present(avc, animated: true, completion: nil)
            
        }
    }

}
