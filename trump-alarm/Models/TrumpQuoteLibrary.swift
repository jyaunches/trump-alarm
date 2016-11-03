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
        TrumpQuote(content: SoundBiteContent.grabEm, audioFile: "grab-em.wav", identifier: "nasty-woman"),
        TrumpQuote(content: SoundBiteContent.datingIvanka, audioFile: "dating-Ivanka.wav", identifier: "bomb-the-shit"),
        TrumpQuote(content: SoundBiteContent.droppingToKnees, audioFile: "dropping-to-your-knees.wav", identifier: "creeping-miss-teen"),
        TrumpQuote(content: SoundBiteContent.muslimShutdown, audioFile: "muslim-shutdown.wav", identifier: "muslim-shutdown"),
        TrumpQuote(content: SoundBiteContent.meganKelly, audioFile: "megan-kelly-blood.wav", identifier: "megan-kelly-blood"),
        TrumpQuote(content: SoundBiteContent.nastyWoman, audioFile: "nasty_woman.wav", identifier: "nasty_woman"),
        TrumpQuote(content: SoundBiteContent.fifthAve, audioFile: "I-could-shoot-somebody.wav", identifier: "I-could-shoot-somebody"),
        TrumpQuote(content: SoundBiteContent.bombTheShit, audioFile: "bomb-the-shit.wav", identifier: "bomb-the-shit"),
        TrumpQuote(content: SoundBiteContent.waterboarding, audioFile: "waterboarding.wav", identifier: "waterboarding"),        
        TrumpQuote(content: SoundBiteContent.handSize, audioFile: "hand-size.wav", identifier: "hand-size"),
        TrumpQuote(content: SoundBiteContent.obamaCofoundedIsis, audioFile: "obama-clinton-co-founded-ISIS.wav", identifier: "obama-clinton-co-founded-ISIS"),
        TrumpQuote(content: SoundBiteContent.fuckHerSheWasMarried, audioFile: "try-and-fuck-her-she-was-married.wav", identifier: "try-and-fuck-her-she-was-married"),
        TrumpQuote(content: SoundBiteContent.mccainNotAHero, audioFile: "not-a-war-hero.wav", identifier: "not-a-war-hero"),
        TrumpQuote(content: SoundBiteContent.secondAmendment, audioFile: "second-ammendment.wav", identifier: "second-ammendment"),
        TrumpQuote(content: SoundBiteContent.takeTheirGuns, audioFile: "take-their-guns-away.wav", identifier: "take-their-guns-away"),
        TrumpQuote(content: SoundBiteContent.buildAWall, audioFile: "build-a-wall.wav", identifier: "build-a-wall"),
        TrumpQuote(content: SoundBiteContent.noPuppet, audioFile: "you're-the-puppet.wav", identifier: "you're-the-puppet"),
        TrumpQuote(content: SoundBiteContent.nucs, audioFile: "won't-rule-out-nuclear-weapons.wav", identifier: "won't-rule-out-nuclear-weapons"),
        TrumpQuote(content: SoundBiteContent.relationshipWithTheBlacks, audioFile: "great-relationship-with-the-blacks.wav", identifier: "great-relationship-with-the-blacks"),
        TrumpQuote(content: SoundBiteContent.teenCreeping, audioFile: "creeping-miss-teen.wav", identifier: "creeping-miss-teen"),
        TrumpQuote(content: SoundBiteContent.theyreRapists, audioFile: "they're-rapist.wav", identifier: "they're-rapist"),
        TrumpQuote(content: SoundBiteContent.carryOutInAStretcher, audioFile: "carried-out-in-a-stretcher.wav", identifier: "   carried-out-in-a-stretcher")
    ]
    
    func getRandomQuote(idPrefix: String) -> TrumpQuote {
        let randomIndex = Int.random(range: 0..<spewQuotes.count)
        var quote = spewQuotes[randomIndex]
        let currentId = quote.identifier
        quote.identifier = idPrefix + "-" + currentId
        
        return quote
    }
    
    func lookup(quote: String) -> TrumpQuote {
        let found = spewQuotes.filter { $0.content == quote }
        
        let randomIndex = Int.random(range: 0..<spewQuotes.count)
        let randomQuote = spewQuotes[randomIndex]
        
        if found.count > 0 {
            return found.last ?? randomQuote
        }
        return randomQuote
    }
}
