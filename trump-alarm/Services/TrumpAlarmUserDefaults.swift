
import Foundation

class TrumpAlarmUserDefaults: NSObject {

    class func flagAsVoted() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "UserHasVoted")
    }
    
    class var userPollingHours: PollingAPIResponse {
        get {
            if let pollingHours = UserDefaults.standard.object(forKey: "userPollingHours") as? PollingAPIResponse {
                return pollingHours
            }
            return PollingAPIResponse()
        }
        set {
            UserDefaults.standard.set(newValue.pollsOpenDate, forKey: "userPollingOpeningHours")
            UserDefaults.standard.set(newValue.pollsCloseDate, forKey: "userPollingClosingHours")
        }
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
