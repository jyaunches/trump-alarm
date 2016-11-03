import Foundation

struct TrumpQuote {

    var content: String = ""
    var audioFile: String = ""
    var identifier: String = ""
    
    var audioFileURL: NSURL?{
        get {
            let truncAudio = audioFile.replacingOccurrences(of: ".wav", with: "")
            if let localPath = Bundle.main.path(forResource: truncAudio, ofType: "wav") {
                return NSURL(fileURLWithPath: localPath)
            }
            return nil
        }
    }
}
