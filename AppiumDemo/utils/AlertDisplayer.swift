import Cocoa

struct AlertDisplayer {
    
    static func displayError(message: String) {
        let alert = NSAlert.init()
        alert.messageText = "Error"
        alert.informativeText = message
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
}
