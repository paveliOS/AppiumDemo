import Foundation

final class AppiumRequestEndRemoteControlSession: AppiumSessionRequest {}

extension AppiumRequestEndRemoteControlSession: HTTPRequest {
    
    var url: URL {
        return URL(string: "\(Appium.host)/session/\(session_id)")!
    }
    
    var requestMethod: HTTPRequestMethod {
        return .delete
    }
    
    var encoding: HTTPRequestParameterEncoding {
        return .json
    }

}
