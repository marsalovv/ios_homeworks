

import UIKit
import FirebaseAuth


class LogInViewController: UIViewController {
    
    //MARK: -Data
    
    var coordinator: ProfileCoordinator?
    weak var loginDelegate: LoginViewControllerDelegate?
    private var delegate: LoginViewControllerDelegate?
    
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
    
    private lazy var logInButton: CustomButton = {
        let button = CustomButton(title: String(localized: "LoginVC loginButton"), TitleColor: .white)
        button.action = { [weak self] in
            self?.pressLoginButton()
        }
        let colorButton = UIColor(patternImage: UIImage(named: "blue_pixel.png")!)
        
        button.layer.cornerRadius = 10
        button.backgroundColor = colorButton
        button.backgroundColor?.withAlphaComponent(1)
        button.setTitle("Введите данные...", for: .disabled)
        button.isEnabled = false
        
        if button.isSelected || button.isHighlighted || button.isEnabled == false {
            button.backgroundColor?.withAlphaComponent(0.8)
        }
        
        return button
    }()
    
    private lazy var createButton: CustomButton = {
        let btn = CustomButton(title: "Войти по FaceID", TitleColor: .systemCyan)
        btn.backgroundColor = .systemFill
        btn.setTitle("...", for: .disabled)
        btn.isEnabled = false
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(pressCreateButton), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
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
        email.textColor = .Pallete.black
        email.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        email.layer.borderWidth = 0.5
        email.layer.borderColor = UIColor.lightGray.cgColor
        email.autocapitalizationType = .none
        email.keyboardType = .emailAddress
        email.delegate = self
        email.text = "angoric@angoric.com"
        email.addTarget(self, action: #selector(emailEdit), for: .editingChanged)
        email.translatesAutoresizingMaskIntoConstraints = false
        
        return email
    }()
    
    private lazy var password: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        //        password.attributedPlaceholder = NSAttributedString(
        //            string: password.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        password.textColor = .Pallete.black
        password.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        password.isSecureTextEntry = true
        password.layer.borderWidth = 0.5
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.delegate = self
        password.text = "qwerty123"
        password.addTarget(self, action: #selector(passwordEdit), for: .editingChanged)
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
        self.view.backgroundColor = UIColor.Pallete.white
        navigationController?.navigationBar.isHidden = true
        
        
        
        if let user = RealmManager.manager.userSave() {
            coordinator?.skipAuthorization(user: user)
        }
        
        
        addSubViews()
        setupConstrains()
        
        emailEdit()
        passwordEdit()
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
        contentView.addSubview(createButton)
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
            //logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            createButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 8),
            createButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            createButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            createButton.heightAnchor.constraint(equalToConstant: 40),
            createButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    private func pressLoginButton() {
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        
        let user = RealmManager.manager.login(email: email, password: password)
        
        coordinator?.pushProfileViewController(verifiedUser: User(
            login: user.email,
            fullName: user.email,
            status: user.description,
            avatar: UIImage(named: "avatar")!
        ))
        
        //        delegate = LoginInspector()
        //        delegate?.checkCredentials(email: email, password: password) {[weak self] authDataResult, error in
        //            if let user = authDataResult?.user {
        //                self?.coordinator?.pushProfileViewController(verifiedUser: User(
        //                    login: user.email!,
        //                    fullName: user.email!,
        //                    status: user.uid,
        //                    avatar: UIImage(named: "avatar")!))
        //            }
        //            if let error = error {
        //                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        //                let action = UIAlertAction(title: "ok", style: .cancel)
        //                alert.addAction(action)
        //                self?.navigationController?.present(alert, animated: true)
        //            }
        //        }
        //
        //
        //
        //
        //
        //        //        let viewModel = LoginViewModel()
        //
        //        switch viewModel.check(email: email, password: password) {
        //        case .usererror:
        //            let alert = UIAlertController(title: "Внимание!!!", message: "Пользователь с именем \(email) не найден!", preferredStyle: .alert)
        //            let alertCansel = UIAlertAction(title: "OK", style: .cancel)
        //            alert.addAction(alertCansel)
        //            present(alert, animated: true)
        //        case .passwordError:
        //            let alert = UIAlertController(title: "Внимание!!!", message: "Не верный пароль!", preferredStyle:.alert)
        //            let alertCansel = UIAlertAction(title: "OK", style: .cancel)
        //            alert.addAction(alertCansel)
        //            present(alert, animated: true)
        //        case .successfully:
        //            coordinator?.pushProfileViewController(verifiedUser: viewModel.user!)
        //        }
        
        //#if DEBUG
        //        let currentUser = TestUserService()
        //#else
        //        let currentUser = CurrentUserService()
        //#endif
        //        guard let loginText = email.text else { return }
        //        guard let passwordText = password.text else { return }
        //        guard let verifiedUser = currentUser.checkingCorrectnessOfLogin(login: loginText) else {
        //            let alert = UIAlertController(title: "Внимание!!!", message: "Пользователь с таким именем не найден!", preferredStyle: .alert)
        //            let alertCansel = UIAlertAction(title: "OK", style: .cancel)
        //            alert.addAction(alertCansel)
        //            present(alert, animated: true)
        //            return
        //        }
        //        guard loginDelegate?.check(login: loginText, password: passwordText) == true else {
        //            let alert = UIAlertController(title: "Внимание!!!", message: "Не верный пароль!", preferredStyle:.alert)
        //            let alertCansel = UIAlertAction(title: "OK", style: .cancel)
        //            alert.addAction(alertCansel)
        //            present(alert, animated: true)
        //            return
        //        }
        //
        //        let profileNav = ProfileViewController(user: verifiedUser)
        //        self.navigationController?.pushViewController(profileNav, animated: true)
        
    }
    
    @objc private func pressCreateButton() {
        let authorizationService = LocalAuthorizationService()
        authorizationService.authorizeIfPossible() {reply in
            DispatchQueue.main.async {
                if reply {
                    let user = User(login: "angoric@angoric.com", fullName: "Angoric", status: "Я авторизовался по FaceID!", avatar: UIImage(named: "avatar")!)
                    self.coordinator?.pushProfileViewController(verifiedUser: user)
                }
            }
        }
        
        //        guard let email = email.text else { return }
        //        guard let password = password.text else { return }
        //        RealmManager.manager.printCount()
        //        RealmManager.manager.delete(email: email, password: password)
        //        RealmManager.manager.printCount()
        //
        
        /*
         delegate = LoginInspector()
         delegate?.signUp(email: email, password: password) {[weak self] authDataResult, error in
         if let user = authDataResult?.user {
         self?.coordinator?.pushProfileViewController(verifiedUser: User(
         login: user.email!,
         fullName: user.email!,
         status: user.uid,
         avatar: UIImage(named: "avatar")!))
         }
         if let error = error {
         let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
         let action = UIAlertAction(title: "ok", style: .cancel)
         alert.addAction(action)
         self?.navigationController?.present(alert, animated: true)
         }
         }
         */
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
    
    @objc private func emailEdit() {
        if email.text != "" && password.text != "" {
            logInButton.isEnabled = true
            createButton.isEnabled = true
            
        } else {
            logInButton.isEnabled = false
            createButton.isEnabled = false
        }
    }
    
    @objc private func passwordEdit() {
        if email.text != "" && password.text != "" {
            logInButton.isEnabled = true
            createButton.isEnabled = true
        } else {
            logInButton.isEnabled = false
            createButton.isEnabled = false
        }
    }
    
}


