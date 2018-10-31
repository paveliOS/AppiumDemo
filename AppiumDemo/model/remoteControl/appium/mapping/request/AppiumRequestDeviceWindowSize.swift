import Foundation

final class AppiumRequestDeviceWindowSize: AppiumSessionRequest {
    
    let window_handle: String
    
    init(session_id: String, window_handle: String) {
        self.window_handle = window_handle
        super.init(session_id: session_id)
    }
    
}

extension AppiumRequestDeviceWindowSize: HTTPRequest {
    
    var url: URL {
        return URL(string: "\(Appium.host)/session/\(session_id)/window/\(window_handle)/size")!
    }
    
    var requestMethod: HTTPRequestMethod {
        return .get
    }
    
    var parameters: [String : Any] {
        return [:]
    }
    
    var encoding: HTTPRequestParameterEncoding {
        return .url
    }
    
}

