final class AppiumTouchAction: Encodable {
    
    let action: String
    let options: AppiumTouchOptions
    
    init(action: String, options: AppiumTouchOptions) {
        self.action = action
        self.options = options
    }
    
}
