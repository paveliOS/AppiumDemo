import Foundation

protocol HTTPRequest: Encodable {
    var url: URL { get }
    var requestMethod: HTTPRequestMethod { get }
    var parameters: [String : Any] { get }
    var encoding: HTTPRequestParameterEncoding { get }
}

extension HTTPRequest {
    
    var parameters: [String : Any] {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
            return jsonDict as! [String : Any]
        } catch {
            NSLog("Failed to serialize \(type(of: self)) with error: \(error.localizedDescription)")
            return [:]
        }
    }
    
}
