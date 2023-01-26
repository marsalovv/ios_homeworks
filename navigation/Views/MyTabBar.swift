
import UIKit

class MyTabBar: UITabBarController {
    private let feedNav: FeedViewController
    private let loginNav: LogInViewController
    private let favoritesTVC: FavoritesTableViewController

    
    init() {
        self.feedNav = FeedViewController()
        self.loginNav = LogInViewController()
        self.favoritesTVC = FavoritesTableViewController()
        feedNav.title = "feed"
        loginNav.title = "login"
        favoritesTVC.title = "Избранное"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [feedNav, favoritesTVC, loginNav]
    }
    
    
}
