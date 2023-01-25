
import UIKit

class ProfileCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let factory = MyLoginFactory()
        let loginInspector = factory.makeLoginInspector()
        let loginVC = LogInViewController()
        loginVC.loginDelegate = loginInspector
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func pushProfileViewController(verifiedUser: User) {

        let profileNav = ProfileViewController(user: verifiedUser)
        profileNav.coordinator = self
        navigationController.pushViewController(profileNav, animated: true)
        
        
    }
    
    func skipAuthorization(user: RealmUserModel) {
        let verifiedUser = User(login: user.email, fullName: user.email, status: user.description, avatar: UIImage(named: "avatar")!)
        let profileVC = ProfileViewController(user: verifiedUser)
        navigationController.setViewControllers([profileVC], animated: false)
    }
}
