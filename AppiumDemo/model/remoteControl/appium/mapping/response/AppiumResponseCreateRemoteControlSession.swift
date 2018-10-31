final class AppiumResponseCreateRemoteControlSession: AppiumResponse {
    
    let value: AppiumCapabilities
    let sessionId: String
    
    init(status: Int, value: AppiumCapabilities, sessionId: String) {
        self.value = value
        self.sessionId = sessionId
        super.init(status: status)
    }
    
    enum CodingKeys: String, CodingKey {
        case value
        case sessionId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(AppiumCapabilities.self, forKey: .value)
        sessionId = try container.decode(String.self, forKey: .sessionId)
        try super.init(from: decoder)
    }
    
}

extension AppiumResponseCreateRemoteControlSession: RemoteControlSessionResponse {
    
    var sessionID: String {
        return sessionId
    }
    
}
