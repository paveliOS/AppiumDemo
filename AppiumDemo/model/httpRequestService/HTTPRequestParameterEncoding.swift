import Alamofire

enum HTTPRequestParameterEncoding {
    case url
    case json
    
    var alamofire: ParameterEncoding {
        switch self {
        case .url:
            return URLEncoding.default
        case .json:
            return JSONEncoding.default
        }
    }
}
