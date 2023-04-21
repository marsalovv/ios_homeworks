
import UIKit

class FeedViewController: UIViewController {
    
    //MARK: - Data
    
    var coordinator: FeedCoordinator?
    
    private lazy var Result: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var wordTextField: UITextField = {
        let wtf = UITextField()
        wtf.delegate = self
        wtf.placeholder = String(localized: "FeedVC wordTextField")
        wtf.textColor = .black
        wtf.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        wtf.layer.borderWidth = 0.5
        wtf.layer.borderColor = UIColor.lightGray.cgColor
        wtf.backgroundColor = .white
        wtf.autocapitalizationType = .none
        wtf.translatesAutoresizingMaskIntoConstraints = false
        
        return wtf
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let btn = CustomButton(title: String(localized: "FeedVC checkGuessButton"), TitleColor: .green)
        btn.action = { [weak self] in
            guard self?.wordTextField.text?.isEmpty == false else { return }
            guard let word = self?.wordTextField.text else {return}
            let feedModel = FeedModel()
            let feedViewModel = FeedViewModel(model: feedModel)
            let result = feedViewModel.check(word: word)
            self?.Result.backgroundColor = result ? .green : .red
        }
        
        return btn
    }()
    
    private lazy var openPostButton: CustomButton = {
        let btn = CustomButton(title: String(localized: "FeedVC openPostButton"), TitleColor: .cyan)
        btn.backgroundColor = .green
        btn.action = { [weak self] in

            self?.coordinator?.openPost()
        }
        

        return btn
    }()
    
    
    //MARK: - Life cyckle / private func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(openPostButton)
        view.addSubview(wordTextField)
        view.addSubview(checkGuessButton)
        view.addSubview(Result)
        self.navigationController?.navigationBar.backgroundColor = .green
        
        setupConstrayns()
        
    }
    
    private func setupConstrayns() {
        NSLayoutConstraint.activate([
            openPostButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor   ),
            openPostButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            wordTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            wordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            wordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            wordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            checkGuessButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            checkGuessButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            Result.topAnchor.constraint(equalTo: wordTextField.bottomAnchor, constant: 24),
            Result.bottomAnchor.constraint(equalTo: checkGuessButton.topAnchor, constant: -24),
            Result.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            Result.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
}

//Mark: - Extension

extension FeedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        true
    }
    
}
