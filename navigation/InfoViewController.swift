

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        btn.setTitle("Alert", for: .normal)
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 150
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 20
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(button)
        self.view.backgroundColor = .yellow
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor   ),
            button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 300),
            button.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        button.addTarget(self, action: #selector(tapAlert), for: .touchUpInside)

    }
    
    @objc func tapAlert() {
        let alert = UIAlertController(title: "Alert!", message: "Следи за собой!", preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .default) { (action : UIAlertAction) in
            self.dismiss(animated: true)
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
