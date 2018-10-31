import Cocoa

protocol RemoteControlRouterProtocol: class {

}

final class RemoteControlRouter {
    
    private static let storyboardName: NSStoryboard.Name = "RemoteControl"
    private static let vcID: NSStoryboard.SceneIdentifier = "RemoteControlViewController"
    
}

extension RemoteControlRouter: RemoteControlRouterProtocol {
    
    static func setupRemoteControlModule(remoteControlService: RemoteControlService) -> NSViewController {
        let router = RemoteControlRouter()
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        let view = storyboard.instantiateController(withIdentifier: vcID) as! RemoteControlViewController
        let presenter = RemoteControlPresenter(view: view, router: router, remoteControlService: remoteControlService)
        view.presenter = presenter
        return view
    }
    
}
