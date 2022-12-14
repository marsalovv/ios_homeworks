
import UIKit

class FeedCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedNav = FeedViewController()
        feedNav.coordinator = self
        feedNav.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "doc.richtext"), tag: 1)
        navigationController.pushViewController(feedNav, animated: true)
    }
    
    func openPost() {
        let postVC = PostViewController()
        postVC.coordinator = self
        navigationController.pushViewController(postVC, animated: true)
    }
    
    func postInfo() {
        let infoVC = InfoViewController()
        infoVC.coordinator = self
        navigationController.present(infoVC, animated: true )
    }
    
    func alertOk() {
        let profileC = ProfileCoordinator(navigationController: navigationController)
        profileC.start()
    }
}


