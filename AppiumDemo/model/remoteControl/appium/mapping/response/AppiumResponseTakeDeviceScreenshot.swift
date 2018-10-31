import Foundation

final class AppiumResponseTakeDeviceScreenshot: AppiumResponse {
    
    let value: String // base64 encoded PNG
    
    init(status: Int, value: String) {
        self.value = value
        super.init(status: status)
    }
    
    enum CodingKeys: String, CodingKey {
        case value
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(String.self, forKey: .value)
        try super.init(from: decoder)
    }
    
}

extension AppiumResponseTakeDeviceScreenshot: RemoteControlDeviceScreenshotResponse {
    
    var screenshot: Data {
        if let data = Data(base64Encoded: value, options: .ignoreUnknownCharacters) {
            return data
        } else {
            NSLog("Failed to parse screenshot base64 string")
            return Data()
        }
    }
    
}
