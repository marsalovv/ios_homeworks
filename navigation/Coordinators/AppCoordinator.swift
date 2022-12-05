
import UIKit

class AppCoordinator: Coordinatable {
    
    var parentCoordinator: Coordinatable?
    var children: [Coordinatable] = []
    
    func start() -> UIViewController{
        let tbvc = UITabBarController()
        let profileC = ProfileCoordinator()
        let feedC = FeedCoordinator()
        tbvc.setViewControllers([
            feedC.start(),
            profileC.start()],
                                animated: true)
        
        return tbvc
    }
}
