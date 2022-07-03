//
//  FeedViewController.swift
//  navigation
//
//  Created by Сергей Марсалов on 29.06.2022.
//

import UIKit


class FeedViewController: UIViewController {
     let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Open post", for: .normal)
        btn.backgroundColor = .systemCyan
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        self.view.backgroundColor = .brown
        self.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "doc.richtext"), tag: 1)
        self.view.addSubview(button)
        self.navigationController?.navigationBar.backgroundColor = .systemBlue

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor   ),
            button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        button.addTarget(self, action: #selector(tabButton), for: .touchUpInside)
    }
        
    @objc func tabButton() {

let postVC = PostViewController()
        
        self.navigationController?.pushViewController(postVC, animated: true)

    }


}
