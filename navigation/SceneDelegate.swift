//
//  SceneDelegate.swift
//  navigation
//
//  Created by Сергей Марсалов on 29.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let tbvc = UITabBarController()
        let feedNav = UINavigationController(rootViewController: FeedViewController())
        feedNav.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "doc.richtext"), tag: 1)
        let profileNav = UINavigationController(rootViewController: ProfileViewController())
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.text.rectangle"), tag: 1)
        tbvc.setViewControllers([feedNav, profileNav], animated: true)
        
        window?.rootViewController = tbvc
        window?.makeKeyAndVisible()
        
    }
    
    
}

