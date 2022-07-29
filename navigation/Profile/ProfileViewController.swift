//
//  ProfileViewController.swift
//  navigation
//
//  Created by Сергей Марсалов on 29.06.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    private lazy var profileHV: ProfileHeaderView = {
        let profileHV = ProfileHeaderView()
        profileHV.translatesAutoresizingMaskIntoConstraints = false
        
        return profileHV
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("изменить title", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(profileHV)
        setupView()
        setupConstrains()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    func setupView() {
        self.title = "Profile"
        self.view.backgroundColor = .lightGray
        self.view.addSubview(button)
    }
    
    func setupConstrains() {
        let safeArie = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileHV.leadingAnchor.constraint(equalTo: safeArie.leadingAnchor, constant: 0),
            profileHV.rightAnchor.constraint(equalTo: safeArie.rightAnchor, constant: 0),
            profileHV.topAnchor.constraint(equalTo: safeArie.topAnchor, constant: 0),
            profileHV.heightAnchor.constraint(equalToConstant: 220),
            
            button.leftAnchor.constraint(equalTo: safeArie.leftAnchor),
            button.rightAnchor.constraint(equalTo: safeArie.rightAnchor),
            button.bottomAnchor.constraint(equalTo: safeArie.bottomAnchor),
        ])
    }
}
