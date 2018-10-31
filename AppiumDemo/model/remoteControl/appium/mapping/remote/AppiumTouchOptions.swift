final class AppiumTouchOptions: Encodable {
    
    let element: String?
    let x: Double
    let y: Double
    let count: Int
    
    init(element: String?, x: Double, y: Double, count: Int) {
        self.element = element
        self.x = x
        self.y = y
        self.count = count
    }

    
}
