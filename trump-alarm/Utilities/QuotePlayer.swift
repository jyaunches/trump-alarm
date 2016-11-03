//
//  QuotePlayer.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 11/2/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit
import AVFoundation

class QuotePlayer: NSObject, AVAudioPlayerDelegate {
    var avPlayer:AVAudioPlayer!
    
    func playQuoteFile(trumpQuote: TrumpQuote) {
        
        
        let truncAudio = trumpQuote.audioFile.replacingOccurrences(of: ".wav", with: "")
        if let fileURL:URL = Bundle.main.url(forResource: truncAudio, withExtension: "wav") {
            
            
            
            // the player must be a field. Otherwise it will be released before playing starts.
            let foo = try? AVAudioPlayer(contentsOf: fileURL)
            if let foo = foo {
                avPlayer = foo
                print("playing \(fileURL)")
                avPlayer.delegate = self
                avPlayer.prepareToPlay()
                avPlayer.volume = 1.0
                avPlayer.play()
            }
            
            
            
        }
        
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer!, successfully flag: Bool) {
        print("finished playing \(flag)")
    }
    
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {                
        print("Audio error occurred.")
    }
    
}
