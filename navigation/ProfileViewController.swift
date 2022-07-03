//
//  ProfileViewController.swift
//  navigation
//
//  Created by Сергей Марсалов on 29.06.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.view.backgroundColor = .blue
        self.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.text.rectangle"), tag: 1)
        self.navigationController?.navigationBar.backgroundColor = .purple
    }


}
