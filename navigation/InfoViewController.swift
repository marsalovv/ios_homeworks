//
//  InfoViewController.swift
//  navigation
//
//  Created by Сергей Марсалов on 03.07.2022.
//

import UIKit

class InfoViewController: UIViewController {
    let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Alert", for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor   ),
            button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        button.addTarget(self, action: #selector(tapAlert), for: .touchUpInside)

    }
    
    @objc func tapAlert() {
        let alert = UIAlertController(title: "Alert!", message: "Следи за собой!", preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .default) { (action : UIAlertAction) in
            print("Ok")
        }
        let cancelAlertAction = UIAlertAction(title: "Отмена", style: .cancel) { (action : UIAlertAction) in
            print("Cansel")
        }
        
        alert.addAction(okAlertAction)
        alert.addAction(cancelAlertAction)
        present(alert, animated: true, completion: nil)

    }


}
