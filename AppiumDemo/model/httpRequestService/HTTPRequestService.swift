import Alamofire

protocol HTTPRequestServiceProtocol: class {
    func execute(request: HTTPRequest, responseHandler: ((HTTPRequestService.HTTPResponse) -> Void)?)
}

final class HTTPRequestService {}

extension HTTPRequestService: HTTPRequestServiceProtocol {
    
    enum HTTPResponse {
        case success(data: Data)
        case failure(error: HTTPRequestError)
    }
    
    func execute(request: HTTPRequest, responseHandler: ((HTTPResponse) -> Void)?) {
        let request = Alamofire.request(request.url, method: request.requestMethod.alamofire, parameters: request.parameters, encoding: request.encoding.alamofire)
        NSLog("Sending: \(request.debugDescription)")
        request.responseJSON { response in
            guard response.error == nil else {
                NSLog("HTTP request failed with error: \(response.error!.localizedDescription)")
                let error = HTTPRequestError.connection(description: response.error!.localizedDescription)
                responseHandler?(HTTPResponse.failure(error: error))
                return
            }
            
            guard let resp = response.response else {
                NSLog("HTTP request failed with error: response object is nil")
                let error = HTTPRequestError.connection(description: "Response is nil")
                responseHandler?(HTTPResponse.failure(error: error))
                return
            }
            
            NSLog("HTTP Response statusCode: \(resp.statusCode)")
            
            guard let data = response.data else {
                NSLog("Failed to receive response data")
                let error = HTTPRequestError.connection(description: "No response data")
                responseHandler?(HTTPResponse.failure(error: error))
                return
            }
            
            if let responseString = String(data: data, encoding: String.Encoding.utf8) {
                NSLog("HTTP Response string: \(responseString)")
            } else {
                NSLog("HTTP Response is not a string")
            }
            
            responseHandler?(HTTPResponse.success(data: data))
        }
    }
    
}
