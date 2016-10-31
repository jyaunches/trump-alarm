
import Foundation

class TrumpAlarmUserDefaults: NSObject {

    class func flagAsVoted() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "UserHasVoted")
    }

    
    class func storePollStart(hour: Int) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "storePollStart")
    }

    class func storePollEnd(hour: Int) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "storePollEnd")
    }
    
    class func storePollStartString(hour: String) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "pollStartString")
    }
    
    class func storePollEndString(hour: String) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "pollEndString")
    }
}
