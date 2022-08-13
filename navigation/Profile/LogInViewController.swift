

import UIKit

class LogInViewController: UIViewController {

//MARK: -Data
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        let colorButton = UIColor(patternImage: UIImage(named: "blue_pixel.png")!)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = colorButton
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var imageVK: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo.png")
        image.isAccessibilityElement = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var email: UITextField = {
        let email = UITextField()
        email.placeholder = "Email or phone"
        email.textColor = .black
        email.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        email.autocapitalizationType = .none
        email.backgroundColor = .lightGray
        email.keyboardType = .emailAddress
        email.translatesAutoresizingMaskIntoConstraints = false
        
        return email
    }()
    
    private lazy var password: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        password.isSecureTextEntry = true
        password.backgroundColor = .lightGray
        password.translatesAutoresizingMaskIntoConstraints = false
        
        return password
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 0.5
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .lightGray
        stackView.clipsToBounds = true
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.addArrangedSubview(email)
        stackView.addArrangedSubview(password)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
        //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        addSubViews()
        setupConstrains()

        logInButton.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
    }
    
        //MARK: -Private

    private func addSubViews() {
        contentView.addSubview(imageVK)
        contentView.addSubview(stackView)
//        contentView.addSubview(email)
//        contentView.addSubview(password)
        contentView.addSubview(logInButton)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
    }
    
    func setupConstrains() {
        let safeArie = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArie.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArie.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArie.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArie.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: logInButton.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageVK.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            imageVK.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageVK.widthAnchor.constraint(equalToConstant: 100),
            imageVK.heightAnchor.constraint(equalToConstant: 100),
        
            stackView.topAnchor.constraint(equalTo: imageVK.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
                                        
        ])
        
    }
    
    @objc func buttonPress() {
        let profileNavv = ProfileViewController()
        self.navigationController?.pushViewController(profileNavv, animated: true)
    }
    
}
