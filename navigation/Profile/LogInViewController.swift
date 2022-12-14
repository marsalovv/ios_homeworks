

import UIKit

class LogInViewController: UIViewController {
    
    //MARK: -Data
    
    var coordinator: ProfileCoordinator?
    var loginDelegate: LoginViewControllerDelegate?
    
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
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .medium
        activity.color = .blue
        activity.hidesWhenStopped = true
        activity.shouldGroupAccessibilityChildren = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        return activity
    }()
    
    private lazy var brutForceButton: CustomButton = {
        let btn = CustomButton(title: "BF", TitleColor: .white)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 17
        btn.action = { [weak self] in
            self?.brutForcePassword()
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    private lazy var logInButton: CustomButton = {
        let button = CustomButton(title: "Войти", TitleColor: .white)
        button.action = { [weak self] in
            self?.buttonPress()
        }
        let colorButton = UIColor(patternImage: UIImage(named: "blue_pixel.png")!)
        
        button.layer.cornerRadius = 10
        button.backgroundColor = colorButton
        button.backgroundColor?.withAlphaComponent(1)
        
        if button.isSelected || button.isHighlighted || button.isEnabled == false {
            button.backgroundColor?.withAlphaComponent(0.8)
        }
        
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
        email.text = "angoric"
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
        password.text = "qwerty123"
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
        stackView.addSubview(activityIndicatorView)
        stackView.addSubview(brutForceButton)
    }
    
    private func setupConstrains() {
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
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            
            brutForceButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -8),
            brutForceButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8),
            brutForceButton.heightAnchor.constraint(equalToConstant: 34),
            brutForceButton.widthAnchor.constraint(equalToConstant: 34)
        ])
        
        
    }
    
    private func buttonPress() {
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        
        let viewModel = LoginViewModel()
        switch viewModel.check(email: email, password: password) {
        case .usererror:
            let alert = UIAlertController(title: "Внимание!!!", message: "Пользователь с именем \(email) не найден!", preferredStyle: .alert)
            let alertCansel = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(alertCansel)
            present(alert, animated: true)
        case .passwordError:
            let alert = UIAlertController(title: "Внимание!!!", message: "Не верный пароль!", preferredStyle:.alert)
            let alertCansel = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(alertCansel)
            present(alert, animated: true)
        case .successfully:
            coordinator?.pushProfileViewController(verifiedUser: viewModel.user!)
            Timer.scheduledTimer(withTimeInterval: 30, repeats: false, block: { _ in
                let alert = UIAlertController(title: "Ошибка", message: "срок авторизации истек", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.coordinator?.pop()
                })
                alert.addAction(ok)
                self.navigationController?.present(alert, animated: true)
            })
        }
        
    }
    
    
    private func randomPassword() -> String {
        let length = [3, 4].randomElement()!
        let letters = String().digits + String().letters
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    private func brutForcePassword() {
        let password = randomPassword()
        let brutForce = BrutForce()
        let queue = DispatchQueue.global(qos: .userInitiated)
        activityIndicatorView.startAnimating()
        queue.async {
            brutForce.bruteForce(passwordToUnlock: password)
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.password.text = password
                self.password.isSecureTextEntry = false
            }
        }
        
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


