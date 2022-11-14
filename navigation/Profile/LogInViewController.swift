

import UIKit
class LogInViewController: UIViewController {
    
    //MARK: -Data
    
    static var loginDelegate: LoginViewControllerDelegate?
    
    private    let notificationCenter = NotificationCenter.default
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        let colorButton = UIColor(patternImage: UIImage(named: "blue_pixel.png")!)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = colorButton
        button.backgroundColor?.withAlphaComponent(1)
        
        if button.isSelected || button.isHighlighted || button.isEnabled == false {
            button.backgroundColor?.withAlphaComponent(0.8)
        }
        
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var imageVK: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.isAccessibilityElement = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var email: UITextField = {
        let email = UITextField()
        email.placeholder = "Email or phone"
        //        email.attributedPlaceholder = NSAttributedString(
        //            string: email.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        email.textColor = .black
        email.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        email.layer.borderWidth = 0.5
        email.layer.borderColor = UIColor.lightGray.cgColor
        email.autocapitalizationType = .none
        email.keyboardType = .emailAddress
        email.delegate = self
        email.translatesAutoresizingMaskIntoConstraints = false
        
        return email
    }()
    
    private lazy var password: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        //        password.attributedPlaceholder = NSAttributedString(
        //            string: password.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        password.textColor = UIColor.black
        password.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        password.isSecureTextEntry = true
        password.layer.borderWidth = 0.5
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.delegate = self
        password.translatesAutoresizingMaskIntoConstraints = false
        
        return password
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 0.5
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
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
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        addSubViews()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: -Private
    
    private func addSubViews() {
        contentView.addSubview(imageVK)
        contentView.addSubview(stackView)
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
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
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
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    @objc func buttonPress() {
#if DEBUG
        let currentUser = TestUserService()
#else
        let currentUser = CurrentUserService()
#endif
        guard let loginText = email.text else { return }
        guard let passwordText = password.text else { return }
        guard let verifiedUser = currentUser.checkingCorrectnessOfLogin(login: loginText) else {
            let alert = UIAlertController(title: "Внимание!!!", message: "Пользователь с таким именем не найден!", preferredStyle: .alert)
            let alertCansel = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(alertCansel)
            present(alert, animated: true)
            return
        }
        guard LogInViewController.loginDelegate?.check(login: loginText, password: passwordText) == true else {
            let alert = UIAlertController(title: "Внимание!!!", message: "Не верный пароль!", preferredStyle:.alert)
            let alertCansel = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(alertCansel)
            present(alert, animated: true)
            return
        }
        
        let profileNavv = ProfileViewController(user: verifiedUser)
        self.navigationController?.pushViewController(profileNavv, animated: true)
        
    }
    
    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        true
    }
    
}


