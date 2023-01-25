

import UIKit

class InfoViewController: UIViewController {
    var coordinator: FeedCoordinator?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var planetLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
        

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
        view.addSubview(button)
        view.addSubview(titleLabel)
        view.addSubview(planetLabel)
        self.view.backgroundColor = .yellow
        
        NetworkService.requestTitleInfoVC(string: "https://jsonplaceholder.typicode.com/todos/13") {title in
            DispatchQueue.main.async {

                self.titleLabel.text = title
            }
        }

        NetworkService.requestPlanet(string: "https://swapi.dev/api/planets/1") {planet in
            
            DispatchQueue.main.async {
                self.planetLabel.text = planet.orbitalPeriod
            }
        }
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor   ),
            button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 100),
            button.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            planetLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            planetLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            planetLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            planetLabel.heightAnchor.constraint(equalToConstant: 50)

        ])
        


    }
    

}
