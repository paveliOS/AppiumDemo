final class AppiumErrorResponse: Decodable {

    let value: ErrorValue
    
    init(value: ErrorValue) {
        self.value = value
    }
    
    struct ErrorValue: Decodable {
        let message: String
    }
    
}
