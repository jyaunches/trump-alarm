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
        
        quoteTextLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(newSize.height)
        }
                
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
