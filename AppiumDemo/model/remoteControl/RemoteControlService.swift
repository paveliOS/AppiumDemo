import Foundation

protocol RemoteControlService: class {
    func createRemoteControlSession(callback: ((RemoteControlSessionResponse?, RemoteControlServiceError?) -> Void)?)
    func endRemoteControlSession(sessionID: String, callback: ((RemoteControlServiceError?) -> Void)?)
    func getWindowSize(sessionID: String, callback: ((RemoteControlDeviceWindowSizeResponse?, RemoteControlServiceError?) -> Void)?)
    func takeDeviceScreenshot(sessionID: String, callback: ((RemoteControlDeviceScreenshotResponse?, RemoteControlServiceError?) -> Void)?)
    func tapOnDevice(sessionID: String, x: Double, y: Double, callback: ((RemoteControlServiceError?) -> Void)?)
}
