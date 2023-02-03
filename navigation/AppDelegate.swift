//
//  AppDelegate.swift
//  navigation
//
//  Created by Сергей Марсалов on 29.06.2022.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        return true
        
//        var key = Data(count: 64)
//        _ = key.withUnsafeMutableBytes { bytes in
//          SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
//        }
//
//        let keychainItemQuery = [
//             kSecValueData: key,
//             kSecClass: kSecClassKey
//         ] as CFDictionary
//
//         let status = SecItemAdd(keychainItemQuery, nil)
//         print("Operation finished with status: \(status)")
//
//
//        let tag = "RealmKey".data(using: .utf8)!
//        let addquery: [String: Any] = [kSecClass as String: kSecClassKey,
//                                       kSecAttrApplicationTag as String: tag,
//                                       kSecValueData as String: key]

    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

