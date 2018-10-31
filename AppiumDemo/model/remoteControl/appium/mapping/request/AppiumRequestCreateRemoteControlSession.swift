import Foundation

final class AppiumRequestCreateRemoteControlSession {
    
    let desiredCapabilities: AppiumCapabilities // (JSONWP specification) Object describing session's desired capabilities
    let requiredCapabilities: AppiumCapabilities? // (JSONWP specification) Object describing session's required capabilities that must be applied by remote end
    let capabilities: AppiumCapabilitiesRequirement? // (W3C specification) object containing 'alwaysMatch' and 'firstMatch' properties

    init(desiredCapabilities: AppiumCapabilities, requiredCapabilities: AppiumCapabilities?, capabilities: AppiumCapabilitiesRequirement?) {
        self.desiredCapabilities = desiredCapabilities
        self.requiredCapabilities = requiredCapabilities
        self.capabilities = capabilities
    }
    
}

extension AppiumRequestCreateRemoteControlSession: HTTPRequest {
    
    var url: URL {
        return URL(string: "\(Appium.host)/session")!
    }
    
    var requestMethod: HTTPRequestMethod {
        return .post
    }
    
    var encoding: HTTPRequestParameterEncoding {
        return .json
    }
    
}
