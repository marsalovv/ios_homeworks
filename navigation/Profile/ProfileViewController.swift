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
        self.view.backgroundColor = .lightGray
        self.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.text.rectangle"), tag: 1)
        
        //self.navigationController?.navigationBar.backgroundColor = .blue

    }
    
    override func viewWillLayoutSubviews() {
//        profileHV.frame = self.view.bounds
        
    }

    override func loadView() {
        super.loadView()
        let size = self.view.frame
        let profileHV = ProfileHeaderView(frame: size)
        self.view.addSubview(profileHV)
    }
    
    
}
