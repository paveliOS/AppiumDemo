import Cocoa

final class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        let appium = Appium()
        let remoteControlView = RemoteControlRouter.setupRemoteControlModule(remoteControlService: appium)
        contentViewController = remoteControlView
    }

}
