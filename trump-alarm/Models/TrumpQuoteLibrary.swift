//
//  TrumpQuoteLibrary.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/31/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class TrumpQuoteLibrary: NSObject {
    let spewQuotes = [
        TrumpQuote(content: SoundBiteContent.grabEm, audioFile: "grab-em.wav", identifier: "spew-nasty-woman"),
        TrumpQuote(content: SoundBiteContent.datingIvanka, audioFile: "dating-Ivanka.wav", identifier: "spew-bomb-the-shit"),
        TrumpQuote(content: SoundBiteContent.droppingToKnees, audioFile: "dropping-to-your-knees.wav", identifier: "spew-creeping-miss-teen"),
        TrumpQuote(content: SoundBiteContent.muslimShutdown, audioFile: "muslim-shutdown.wav", identifier: "spew-muslim-shutdown"),
        TrumpQuote(content: SoundBiteContent.meganKelly, audioFile: "megan-kelly-blood.wav", identifier: "spew-megan-kelly-blood"),
        TrumpQuote(content: SoundBiteContent.nastyWoman, audioFile: "nasty_woman.wav", identifier: "spew-nasty_woman"),
        TrumpQuote(content: SoundBiteContent.fifthAve, audioFile: "I-could-shoot-somebody.wav", identifier: "spew-I-could-shoot-somebody"),
        TrumpQuote(content: SoundBiteContent.bombTheShit, audioFile: "bomb-the-shit.wav", identifier: "spew-bomb-the-shit"),
        TrumpQuote(content: SoundBiteContent.waterboarding, audioFile: "waterboarding.wav", identifier: "spew-waterboarding"),
        TrumpQuote(content: SoundBiteContent.waterboarding, audioFile: "waterboarding.wav", identifier: "spew-waterboarding"),
        TrumpQuote(content: SoundBiteContent.handSize, audioFile: "hand-size.wav", identifier: "spew-hand-size"),
        TrumpQuote(content: SoundBiteContent.obamaCofoundedIsis, audioFile: "obama-clinton-co-founded-ISIS.wav", identifier: "spew-obama-clinton-co-founded-ISIS"),
        TrumpQuote(content: SoundBiteContent.fuckHerSheWasMarried, audioFile: "try-and-fuck-her-she-was-married.wav", identifier: "spew-try-and-fuck-her-she-was-married"),
        TrumpQuote(content: SoundBiteContent.mccainNotAHero, audioFile: "not-a-war-hero.wav", identifier: "spew-not-a-war-hero"),
        TrumpQuote(content: SoundBiteContent.secondAmendment, audioFile: "second-ammendment.wav", identifier: "spew-second-ammendment"),
        TrumpQuote(content: SoundBiteContent.takeTheirGuns, audioFile: "take-their-guns-away.wav", identifier: "spew-take-their-guns-away"),
        TrumpQuote(content: SoundBiteContent.buildAWall, audioFile: "build-a-wall.wav", identifier: "spew-build-a-wall"),
        TrumpQuote(content: SoundBiteContent.noPuppet, audioFile: "you're-the-puppet.wav", identifier: "spew-you're-the-puppet"),
        TrumpQuote(content: SoundBiteContent.nucs, audioFile: "won't-rule-out-nuclear-weapons.wav", identifier: "spew-won't-rule-out-nuclear-weapons"),
        TrumpQuote(content: SoundBiteContent.relationshipWithTheBlacks, audioFile: "great-relationship-with-the-blacks.wav", identifier: "spew-great-relationship-with-the-blacks"),
        TrumpQuote(content: SoundBiteContent.teenCreeping, audioFile: "creeping-miss-teen.wav", identifier: "spew-creeping-miss-teen"),
        TrumpQuote(content: SoundBiteContent.theyreRapists, audioFile: "they're-rapist.wav", identifier: "spew-they're-rapist"),
        TrumpQuote(content: SoundBiteContent.carryOutInAStretcher, audioFile: "carried-out-in-a-stretcher.wav", identifier: "spew-   carried-out-in-a-stretcher")
    ]
    
    func getRandomQuote() -> TrumpQuote {
        let randomIndex = Int.random(range: 0..<spewQuotes.count)
        return spewQuotes[randomIndex]
    }
    
    func lookup(quote: String) -> TrumpQuote {
        let found = spewQuotes.filter { $0.content == quote }
        
        if found.count > 0 {
            return found.last ?? getRandomQuote()
        }
        return getRandomQuote()
    }
}
