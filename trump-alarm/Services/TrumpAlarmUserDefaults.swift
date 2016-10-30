
import Foundation

class TrumpAlarmUserDefaults: NSObject {

    class func flagAsVoted() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "UserHasVoted")
    }

}