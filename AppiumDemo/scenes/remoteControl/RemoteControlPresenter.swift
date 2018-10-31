import Foundation

protocol RemoteControlViewPresenter: class {
    func viewDidLoad()
    func onStartAction()
    func onEndAction()
    func onRefresh()
    func onScreenshotClick(location: NSPoint, in bounds: NSRect)
}

final class RemoteControlPresenter {
    
    private weak var view: RemoteControlView?
    private let router: RemoteControlRouterProtocol
    private let remoteControlService: RemoteControlService
    private var deviceWindowSize: NSSize?
    
    init(view: RemoteControlView?, router: RemoteControlRouterProtocol, remoteControlService: RemoteControlService) {
        self.view = view
        self.router = router
        self.remoteControlService = remoteControlService
    }
    
    private func getWindowSize(callback: ((NSSize) -> Void)?) {
        guard let sessionID = UserDefaults.standard.sessionID else {
            AlertDisplayer.displayError(message: "Remote control session is not created")
            return
        }
        remoteControlService.getWindowSize(sessionID: sessionID) { response, error in
            DispatchQueue.main.async {
                if let err = error {
                    AlertDisplayer.displayError(message: err.description)
                } else {
                    let resp = response!
                    callback?(resp.size)
                }
            }
        }
    }
    
    private func takeDeviceScreenshot() {
        guard let sessionID = UserDefaults.standard.sessionID else {
            AlertDisplayer.displayError(message: "Remote control session is not created")
            return
        }
        remoteControlService.takeDeviceScreenshot(sessionID: sessionID) { response, error in
            DispatchQueue.main.async {
                if let err = error {
                    AlertDisplayer.displayError(message: err.description)
                } else {
                    let resp = response!
                    self.view?.updateDeviceScreenshot(with: resp.screenshot)
                }
            }
        }
    }
    
}

extension RemoteControlPresenter: RemoteControlViewPresenter {
    
    func viewDidLoad() {
        
    }
    
    func onStartAction() {
        remoteControlService.createRemoteControlSession { response, error in
            DispatchQueue.main.async {
                if let err = error {
                    AlertDisplayer.displayError(message: err.description)
                } else {
                    let resp = response!
                    UserDefaults.standard.sessionID = resp.sessionID
                    self.getWindowSize { size in
                        self.deviceWindowSize = size
                        self.takeDeviceScreenshot()
                    }
                    
                }
                self.view?.updateSessionState(started: error == nil)
            }
        }
    }
    
    func onEndAction() {
        if let sessionID = UserDefaults.standard.sessionID {
            remoteControlService.endRemoteControlSession(sessionID: sessionID) { error in
                DispatchQueue.main.async {
                    if let err = error {
                        AlertDisplayer.displayError(message: err.description)
                    }
                }
            }
        }
        UserDefaults.standard.sessionID = nil
        deviceWindowSize = nil
        view?.updateSessionState(started: false)
    }
    
    func onRefresh() {
        getWindowSize { size in
            DispatchQueue.main.async {
                self.deviceWindowSize = size
                self.takeDeviceScreenshot()
            }
        }
    }
    
    func onScreenshotClick(location: NSPoint, in bounds: NSRect) {
        guard let sessionID = UserDefaults.standard.sessionID else {
            AlertDisplayer.displayError(message: "Remote control session is not created")
            return
        }
        guard let deviceWindowSize = deviceWindowSize else {
            AlertDisplayer.displayError(message: "Can't convert click location because device window size is not set")
            return
        }
        
        // Convert location from bottom left corner origin to top left corner origin
        let topLeftCornerOriginLocation = NSPoint(x: location.x, y: bounds.height - location.y)
        
        // Convert location from screenshot image view coordinate space to device coordinate space
        let deviceWindowTapX = (topLeftCornerOriginLocation.x * deviceWindowSize.width) / bounds.width
        let deviceWindowTapY = (topLeftCornerOriginLocation.y * deviceWindowSize.height) / bounds.height
        
        remoteControlService.tapOnDevice(sessionID: sessionID, x: Double(deviceWindowTapX), y: Double(deviceWindowTapY)) { error in
            DispatchQueue.main.async {
                if let err = error {
                    AlertDisplayer.displayError(message: err.description)
                } else {
                    self.takeDeviceScreenshot()
                }
            }
        }
    }
    
}
