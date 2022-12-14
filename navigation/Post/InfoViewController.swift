

import UIKit

class InfoViewController: UIViewController {
    var coordinator: FeedCoordinator?
    
    private lazy var button: CustomButton = {
        let btn = CustomButton(title: "Alert")
        btn.action = { [weak self] in
            let alert = UIAlertController(title: "Alert!", message: "Следи за собой!", preferredStyle: .alert)
            let okAlertAction = UIAlertAction(title: "OK", style: .default) { (action : UIAlertAction) in
                self?.dismiss(animated: true)
                self?.coordinator?.alertOk()
            }
            let cancelAlertAction = UIAlertAction(title: "Отмена", style: .cancel) { (action : UIAlertAction) in
                print("Cansel")
            }

            alert.addAction(okAlertAction)
            alert.addAction(cancelAlertAction)
            self?.present(alert, animated: true)
            

        }
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 100)
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
        


    }
    

}
