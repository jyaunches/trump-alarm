import Foundation

class TrumpQuote: NSObject, NSCoding {

    var title: String = ""
    var content: String = ""
    var audioFile: String = ""

    init(title: String, content: String, audioFile: String) {
        self.title = title
        self.content = content
        self.audioFile = audioFile
    }

    required convenience init?(coder decoder: NSCoder) {
        let title = decoder.decodeObject(forKey: "trump-quote-title") as! String
        let content = decoder.decodeObject(forKey: "trump-quote-content") as! String
        let audioFile = decoder.decodeObject(forKey: "trump-quote-audioFile") as! String

        self.init(title: title, content: content, audioFile: audioFile)
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.title, forKey: "trump-quote-title")
        coder.encode(self.content, forKey: "trump-quote-content")
        coder.encode(self.audioFile, forKey: "trump-quote-audioFile")
    }
}
