
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let navCon = UINavigationController()
appCoordinator = AppCoordinator(navigationController: navCon)
let tab = TabCoordinator(navCon)
        tab.start()
        window?.rootViewController = navCon
        window?.makeKeyAndVisible()

    }
    
}

