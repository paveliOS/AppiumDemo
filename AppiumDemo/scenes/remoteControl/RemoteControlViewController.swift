import Cocoa

protocol RemoteControlView: class {
    func updateSessionState(started: Bool)
    func updateDeviceScreenshot(with image: Data)
}

final class RemoteControlViewController: NSViewController {
    
    @IBOutlet private var startButton: NSButton!
    @IBOutlet private var sessionControls: NSStackView!
    @IBOutlet private var screenshotImageView: NSImageView!
    @IBOutlet private var screenshotImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var screenshotImageViewHeightConstraint: NSLayoutConstraint!
    
    var presenter: RemoteControlViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction private func actionStart(_ sender: NSButton) {
        sender.isEnabled = false
        presenter.onStartAction()
    }
    
    @IBAction private func actionEnd(_ sender: NSButton) {
        sender.isEnabled = false
        presenter.onEndAction()
    }
    
    @IBAction private func actionRefresh(_ sender: NSButton) {
        presenter.onRefresh()
    }
    
    @IBAction private func onScreenshotClick(_ sender: NSClickGestureRecognizer) {
        let location = sender.location(in: screenshotImageView)
        presenter.onScreenshotClick(location: location, in: screenshotImageView.bounds)
    }


}

extension RemoteControlViewController: RemoteControlView {
    
    func updateSessionState(started: Bool) {
        startButton.isHidden = started
        startButton.isEnabled = !started
        sessionControls.views.forEach {
            if let control = $0 as? NSControl {
                control.isEnabled = started
            }
        }
        sessionControls.isHidden = !started
        screenshotImageView.isHidden = !started
        screenshotImageView.image = nil
    }
    
    func updateDeviceScreenshot(with image: Data) {
        if let screenshot = NSImage(data: image) {
            screenshotImageView.image = screenshot
            let ratio = screenshot.size.width / screenshot.size.height
            let maxHeight: CGFloat = 1334
            let screenshotImageViewHeight = min(maxHeight, screenshot.size.height)
            screenshotImageViewHeightConstraint.constant = screenshotImageViewHeight
            screenshotImageViewWidthConstraint.constant = screenshotImageViewHeight * ratio
        } else {
            NSLog("Failed to parse screenshot data")
        }
    }
    
}
