
import UIKit

class MyTabBar: UITabBarController {
    private let feedNav: FeedViewController
    private let loginNav: LogInViewController
    private let mapVC: MapViewController
    private let favoritesTVC: FavoritesTableViewController

    
    init() {
        self.feedNav = FeedViewController()
        self.loginNav = LogInViewController()
        self.mapVC = MapViewController()
        self.favoritesTVC = FavoritesTableViewController()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [mapVC, feedNav, favoritesTVC, loginNav]
    }
    
    
}
