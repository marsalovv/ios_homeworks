
import UIKit

class MyTabBar: UITabBarController {
    private let feedNav: FeedViewController
    private let loginNav: LogInViewController
    
    init() {
        self.feedNav = FeedViewController()
        self.loginNav = LogInViewController()
        feedNav.title = "feed"
        loginNav.title = "login"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [feedNav, loginNav]
    }
    
    
}
