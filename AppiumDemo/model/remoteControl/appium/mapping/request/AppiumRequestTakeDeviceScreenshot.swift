import Foundation

final class AppiumRequestTakeDeviceScreenshot: AppiumSessionRequest {}

extension AppiumRequestTakeDeviceScreenshot: HTTPRequest {
    
    var url: URL {
        return URL(string: "\(Appium.host)/session/\(session_id)/screenshot")!
    }
    
    var requestMethod: HTTPRequestMethod {
        return .get
    }
    
    var encoding: HTTPRequestParameterEncoding {
        return .url
    }
    
}
