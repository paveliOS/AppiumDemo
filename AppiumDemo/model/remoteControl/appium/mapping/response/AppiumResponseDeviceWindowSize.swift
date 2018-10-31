import Foundation

final class AppiumResponseDeviceWindowSize: AppiumResponse {
    
    let value: SizeValue
    
    init(status: Int, value: SizeValue) {
        self.value = value
        super.init(status: status)
    }
    
    struct SizeValue: Decodable {
        let width: Double
        let height: Double
    }
    
    enum CodingKeys: String, CodingKey {
        case value
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(SizeValue.self, forKey: .value)
        try super.init(from: decoder)
    }
    
}

extension AppiumResponseDeviceWindowSize: RemoteControlDeviceWindowSizeResponse {
    
    var size: NSSize {
        return NSSize(width: value.width, height: value.height)
    }
    
}
