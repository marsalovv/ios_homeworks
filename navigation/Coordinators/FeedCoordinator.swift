
import UIKit

class FeedCoordinator: Coordinatable {
    
    var parentCoordinator: Coordinatable?
    var children: [Coordinatable] = []
    
    func start() -> UIViewController {
        let feedNav = UINavigationController(rootViewController: FeedViewController())
        feedNav.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "doc.richtext"), tag: 1)
 
        return feedNav
    }
}
