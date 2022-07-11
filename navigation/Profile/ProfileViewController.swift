//
//  ProfileViewController.swift
//  navigation
//
//  Created by Сергей Марсалов on 29.06.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHV = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(profileHV)
        self.title = "Profile"
        self.view.backgroundColor = .lightGray
        
    }
    
    override func loadView() {
        super.loadView()
        profileHV = ProfileHeaderView(frame: self.view.frame)
        
    }
    
    
}
