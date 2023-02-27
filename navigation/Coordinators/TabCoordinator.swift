
import UIKit

class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let tbvc = MyTabBar()
        navigationController.pushViewController(tbvc, animated: true)
        

    }
}



enum TabBarPage {
    case feed
    case favorites
    case map
    case login
    

    init?(index: Int) {
        switch index {
        case 0:
            self = .feed
        case 1:
            self = .favorites
        case 2:
            self = .map
        case 3:
            self = .login
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .feed :
            return "Feed"
        case .favorites:
            return "Избранное"
        case .map:
            return "Карта"
        case .login :
            return "Аккаунт"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .feed :
            return 0
        case .favorites:
            return 1
        case .map:
            return 2
        case .login :
            return 3
        }
    }

    // Add tab icon value
    
    // Add tab icon selected / deselected color
    
    // etc
}


class TabCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    
    //    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController
    
    //var type: CoordinatorType { .tab }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        //Давайте определим, какие страницы мы хотим добавить в панель вкладок
        
        let pages: [TabBarPage] = [.feed, .favorites, .map, .login]
            //.sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        //Инициализация ViewControllers или этих страниц
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)

    }
    
    deinit {
        print("TabCoordinator deinit")
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        /// Установить делегат для UITabBarController
        //        tabBarController.delegate = self
        ///Назначьте контроллеры страницы
        tabBarController.setViewControllers(tabControllers, animated: true)
        ///Пусть установим индекс
        tabBarController.selectedIndex = TabBarPage.feed.pageOrderNumber()
        /// Styling
        tabBarController.tabBar.isTranslucent = true
        
        ///На этом шаге мы прикрепляем tabBarController к навигационному контроллеру, связанному с этим координатором.
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: nil,
                                                     tag: page.pageOrderNumber())
        
        switch page {
        case .feed :
            //При необходимости: каждый поток панели вкладок может иметь своего собственного координатора.
            let feedVC = FeedViewController()
            feedVC.title = String(localized: "title FeedVC")
            navController.pushViewController(feedVC, animated: true)
//            let feedC = FeedCoordinator(navigationController: navController)
//            feedC.start()
        case .favorites:
            let favoritesVC = FavoritesTableViewController()
            favoritesVC.title = String(localized: "title FavoritesTVC")
            navController.pushViewController(favoritesVC, animated: true)
        case .map:
            let mapVC = MapViewController()
            mapVC.title = String(localized: "title MapVC")
            mapVC.tabBarItem = UITabBarItem(title: String(localized: "title MapVC"), image: UIImage(systemName: "map.circle"), selectedImage: UIImage(systemName: "map.circle.fill"))
            navController.pushViewController(mapVC, animated: true)
        case .login:
//            let loginVC = LogInViewController()
//            loginVC.title = String(localized: "title LoginVC")
//            navController.pushViewController(loginVC, animated: true)
            let loginC = ProfileCoordinator(navigationController: navController)
            loginC.start()
        }
        return navController
    }
    
    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    
}
