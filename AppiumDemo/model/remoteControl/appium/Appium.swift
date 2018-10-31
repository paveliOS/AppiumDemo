import Foundation

final class Appium {
    
    // Refer to http://appium.io/docs/en/drivers/ios-xcuitest-real-devices/ when you set these constants
    static let host = "http://0.0.0.0:4723/wd/hub" // Set your Appium server host:port here
    private static let deviceUDID = "" // Set it to connected device udid
    private static let devicePlatform = "12.0" // Set it to connected device iOS version
    private static let updatedWDABundleId: String? = "" // Set bundleID of WebDriverAgentRunner app (if you manually created provisioning profile for it)
    private static let teamID = "" // Your teamID
    private static let testedAppBundleID = "" // Set bundleID of the tested app or some default app like Clock "com.apple.mobiletimer"
    
    private let requestService: HTTPRequestServiceProtocol
    
    init() {
        requestService = HTTPRequestService()
    }
    
    private func executeAppiumRequest<T: AppiumResponse>(request: HTTPRequest, decodeAs type: T.Type, callback: ((T?, RemoteControlServiceError?) -> Void)?) {
        requestService.execute(request: request) { response in
            switch response {
            case .success(data: let data):
                do {
                    let decoder = JSONDecoder()
                    // First decode status, that every appium response contains
                    let statusResponse = try decoder.decode(AppiumResponse.self, from: data)
                    if let status = AppiumResponseStatus(rawValue: statusResponse.status) {
                        switch status {
                        case .success:
                            // Now decode as type passed by client
                            let response = try decoder.decode(type, from: data)
                            callback?(response, nil)
                        default:
                            // Now decode as error response
                            let errorResponse = try decoder.decode(AppiumErrorResponse.self, from: data)
                            callback?(nil, RemoteControlServiceError.parse(description: errorResponse.value.message))
                        }
                    } else {
                        callback?(nil, RemoteControlServiceError.parse(description: "Unknown appium response status on \(request): \(statusResponse.status)"))
                    }
                } catch {
                    callback?(nil, RemoteControlServiceError.parse(description: error.localizedDescription))
                }
            case .failure(error: let error):
                switch error {
                case .connection(description: let descr):
                    callback?(nil, RemoteControlServiceError.connection(description: descr))
                }
            }
        }
    }
    
}

extension Appium: RemoteControlService {
    
    func createRemoteControlSession(callback: ((RemoteControlSessionResponse?, RemoteControlServiceError?) -> Void)?) {
        let testingDeviceCapabilities = AppiumCapabilities(platformVersion: Appium.devicePlatform, takesScreenshot: true, xcodeOrgId: Appium.teamID, xcodeSigningId: "iPhone Developer", updatedWDABundleId: Appium.updatedWDABundleId, bundleId: Appium.testedAppBundleID, udid: Appium.deviceUDID)
        let createRemoteControlSessionReq = AppiumRequestCreateRemoteControlSession(desiredCapabilities: testingDeviceCapabilities, requiredCapabilities: nil, capabilities: nil)
        executeAppiumRequest(request: createRemoteControlSessionReq, decodeAs: AppiumResponseCreateRemoteControlSession.self) { response, error in
            if let err = error {
                NSLog(err.description)
            }
            callback?(response, error)
        }
    }
    
    func getWindowSize(sessionID: String, callback: ((RemoteControlDeviceWindowSizeResponse?, RemoteControlServiceError?) -> Void)?) {
        let windowSizeReq = AppiumRequestDeviceWindowSize(session_id: sessionID, window_handle: "current")
        executeAppiumRequest(request: windowSizeReq, decodeAs: AppiumResponseDeviceWindowSize.self) { response, error in
            if let err = error {
                NSLog(err.description)
            }
            callback?(response, error)
        }
    }
    
    func takeDeviceScreenshot(sessionID: String, callback: ((RemoteControlDeviceScreenshotResponse?, RemoteControlServiceError?) -> Void)?) {
        let takeScreenshotReq = AppiumRequestTakeDeviceScreenshot(session_id: sessionID)
        executeAppiumRequest(request: takeScreenshotReq, decodeAs: AppiumResponseTakeDeviceScreenshot.self) { response, error in
            if let err = error {
                NSLog(err.description)
            }
            callback?(response, error)
        }
    }
    
    func endRemoteControlSession(sessionID: String, callback: ((RemoteControlServiceError?) -> Void)?) {
        let endSessionReq = AppiumRequestEndRemoteControlSession(session_id: sessionID)
        executeAppiumRequest(request: endSessionReq, decodeAs: AppiumResponse.self) { response, error in
            if let err = error {
                NSLog(err.description)
            }
            callback?(error)
        }
    }
    
    func tapOnDevice(sessionID: String, x: Double, y: Double, callback: ((RemoteControlServiceError?) -> Void)?) {
        let tapOptions = AppiumTouchOptions(element: nil, x: x, y: y, count: 1)
        let tapAction = AppiumTouchAction(action: "tap", options: tapOptions)
        let tapReq = AppiumRequestPerformTouchOnDevice(session_id: sessionID, actions: [tapAction])
        executeAppiumRequest(request: tapReq, decodeAs: AppiumResponse.self) { response, error in
            if let err = error {
                NSLog(err.description)
            }
            callback?(error)
        }
    }
    
}
