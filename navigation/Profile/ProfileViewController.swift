

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    //MARK: - Data
    
    var coordinator: ProfileCoordinator?
    let postsArray = Post.makePostsArray()
    var user: User
    private lazy var profileHV: ProfileHeaderView = {
        let profileHV = ProfileHeaderView()
        profileHV.translatesAutoresizingMaskIntoConstraints = false
        
        return profileHV
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "photo")
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        #if DEBUG
//        self.view.backgroundColor = .systemRed
//        #else
//        self.view.backgroundColor = .systemGreen
//        #endif
//
        view.backgroundColor = .Pallete.white
        self.view.addSubview(tableView)

        setupConstrains()
    }
    
    //MARK: - Private
    
    private func setupConstrains() {
        let safeArie = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArie.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArie.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArie.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArie.bottomAnchor)
        ])
    }
    
}

//MARK: - Datasource/Delegate

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       2
   }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return postsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "photo", for: indexPath) as! PhotosTableViewCell
            cell.setupCell()
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
            let post = postsArray[indexPath.row]
            cell.action = {
                CoreDataManager.manager.addFavorites(post: post)
            }
            cell.setupCell(post)

            return cell
        }
        
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = ProfileHeaderView()
                         header.setupViewCurrendUser(user: user)
            
            return header
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photoGallery = PhotosViewController()
            navigationController?.pushViewController(photoGallery, animated: true)
        }
    
    }
    

    
}
