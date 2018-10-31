import Foundation

final class AppiumRequestPerformTouchOnDevice: AppiumSessionRequest {
    
    let actions: [AppiumTouchAction]
    
    init(session_id: String, actions: [AppiumTouchAction]) {
        self.actions = actions
        super.init(session_id: session_id)
    }
    
}

extension AppiumRequestPerformTouchOnDevice: HTTPRequest {
    
    var url: URL {
        return URL(string: "\(Appium.host)/session/\(session_id)/touch/perform")!
    }
    
    var requestMethod: HTTPRequestMethod {
        return .post
    }
    
    var encoding: HTTPRequestParameterEncoding {
        return .json
    }
    
}
