
import UIKit
import StorageService

class PostViewController: UIViewController {
    
    var coordinator: FeedCoordinator?
    let post = Post(author: "marsalovv", description: "my post", image: "", likes: 123, views: 321)
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.view.backgroundColor = .label
        self.navigationController?.navigationBar.backgroundColor = .green
        self.title = post.description
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(tapInfo))
    }

    @objc func tapInfo() {
//        let infoVC = InfoViewController()
//        self.navigationController?.present(infoVC, animated: true)
//        let feedC = FeedCoordinator(navigationController: self.navigationController!)
//        feedC.postInfo()
        self.coordinator?.postInfo()
    }
    
    
}
