import Foundation

extension UserDefaults {
    
    var sessionID: String? {
        get {
            return string(forKey: #function)
        }
        set {
            setValue(newValue, forKey: #function)
        }
    }
    
}
