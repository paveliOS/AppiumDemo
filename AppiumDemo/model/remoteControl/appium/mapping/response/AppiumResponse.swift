class AppiumResponse: Decodable {
    
    let status: Int
    
    init(status: Int) {
        self.status = status
    }
    
}
