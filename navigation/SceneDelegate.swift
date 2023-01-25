
import UIKit
import FirebaseAuth


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        let navCon = UINavigationController()
let tab = TabCoordinator(navCon)
        tab.start()
        window?.rootViewController = navCon
        window?.makeKeyAndVisible()
        
        networkService()

    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        try? Auth.auth().signOut()
    }
    
    private func networkService() {
        guard let urlOne = URL(string: "https://swapi.dev/api/people/8")  else { return }
        guard let urlTwo = URL(string: "https://swapi.dev/api/starships/3") else { return }
        guard let urlThree = URL(string: "https://swapi.dev/api/planets/5") else { return }
                
                let one = NetworkService.AppConfiguration.one(urlOne)
                let two = NetworkService.AppConfiguration.two(urlTwo)
                let three = NetworkService.AppConfiguration.three(urlThree)
        
        guard let appConfiguration = [one, two, three].randomElement() else { return }
        
        NetworkService.request(appConfiguration: appConfiguration)
    }
    
}

