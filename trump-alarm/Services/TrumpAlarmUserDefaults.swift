
import Foundation

class TrumpAlarmUserDefaults: NSObject {

    class var hasVoted: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "UserHasVoted")
        }
        set {
            UserDefaults.standard.set(true, forKey: "UserHasVoted")
        }
        
    }
    
//    class var nextElection: Date {
//        get {
//            return UserDefaults.standard.set(<#T##value: Any?##Any?#>, forKey: <#T##String#>)(forKey: "nextElection") as? Date
//        }
//        set {
//            UserDefaults.standard.object(forKey: "nextElection")
//        }
//    }

    
    class var userPollingHours: PollingAPIResponse {
        get {
            let pollsOpen = UserDefaults.standard.object(forKey: "userPollingOpeningHours") as? Date
            let pollsClose = UserDefaults.standard.object(forKey: "userPollingClosingHours") as? Date
            return PollingAPIResponse(pollsOpen: pollsOpen, pollsClose: pollsClose)
        }
        set {
            UserDefaults.standard.set(newValue.pollsOpenDate, forKey: "userPollingOpeningHours")
            UserDefaults.standard.set(newValue.pollsCloseDate, forKey: "userPollingClosingHours")
        }
    }
    
    class var hasSeenIntro: Bool {
        set {
            UserDefaults.standard.set(true, forKey: "hasSeenIntro")
        }
        get {
            return UserDefaults.standard.bool(forKey: "hasSeenIntro")
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
