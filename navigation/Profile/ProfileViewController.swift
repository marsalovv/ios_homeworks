

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Data
    
    let postsArray = Post.getPostsArray()
    private lazy var profileHV: ProfileHeaderView = {
        let profileHV = ProfileHeaderView()
        profileHV.translatesAutoresizingMaskIntoConstraints = false
        
        return profileHV
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .lightGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        cell.setupCell(postsArray[indexPath.row])
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ProfileHeaderView()
        return header
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
}
