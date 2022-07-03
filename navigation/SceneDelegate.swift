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
        let profileNav = UINavigationController(rootViewController: ProfileViewController())
        tbvc.viewControllers = [feedNav, profileNav]
        
        window?.rootViewController = tbvc
        window?.makeKeyAndVisible()
    }


}

