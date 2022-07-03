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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(tabInfo))
    }

    @objc func tabInfo() {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
