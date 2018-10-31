import Foundation

enum RemoteControlServiceError: Error {
    case connection(description: String)
    case parse(description: String)
    
    var description: String {
        switch self {
        case .connection(description: let descr), .parse(description: let descr):
            return descr
        }
    }
}
