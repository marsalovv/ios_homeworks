//
//  PostViewController.swift
//  navigation
//
//  Created by Сергей Марсалов on 30.06.2022.
//

import UIKit

class PostViewController: UIViewController {
    let post = Post(title: "My post")
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.view.backgroundColor = .systemCyan
        self.navigationController?.navigationBar.backgroundColor = .green
        self.title = post.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(tapInfo))
    }

    @objc func tapInfo() {
        let infoVC = InfoViewController()
        self.navigationController?.present(infoVC, animated: true)
    }

}
