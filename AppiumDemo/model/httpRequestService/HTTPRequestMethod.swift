import Alamofire

enum HTTPRequestMethod {
    case get
    case post
    case delete
    
    var alamofire: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .delete:
            return .delete
        }
    }
}
