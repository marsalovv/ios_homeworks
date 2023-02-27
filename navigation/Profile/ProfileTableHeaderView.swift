
import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - Data
    
    
    private lazy var castomView: UIView = {
        let view = UIView()
        view.backgroundColor = .Pallete.white
        view.alpha = 0.0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var closeImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.alpha = 0.0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(closeImageAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var avatarImage: UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage()
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 50
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.lightGray.cgColor
        avatar.isAccessibilityElement = true
        avatar.accessibilityLabel = "avatar"
        avatar.isUserInteractionEnabled = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        return avatar
    }()
    
    private lazy var  nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .Pallete.black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let status = UILabel()
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = .Pallete.black
        status.backgroundColor = .systemFill
        status.translatesAutoresizingMaskIntoConstraints = false
        
        return status
    }()
    
    private lazy var button :CustomButton = {
        let btn = CustomButton(title: "Show status", TitleColor: .white)
        btn.action = { [weak self] in
            guard let status = self?.statusLabel.text else { return }
            print(status)
        }
        
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 14
        btn.layer.shadowRadius = 4
        btn.layer.shadowOffset.width = 4
        btn.layer.shadowOffset.height = 4
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.7
        
        return btn
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.textColor = .Pallete.black
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderWidth = 1.0
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var imagePosition = avatarImage.layer.position
    private lazy var imageBounds = avatarImage.layer.bounds
    
    //MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: nil)
        setupView()
        setupConstrains()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Setup view
    
    func setupViewCurrendUser(user: User) {
        self.avatarImage.image = user.avatar
        self.nameLabel.text = user.fullName
        self.statusLabel.text = user.status
    }
    private func setupView() {
        [castomView, closeImageButton, button, statusLabel, avatarImage, statusTextField, nameLabel].forEach {addSubview($0)}
    }
    
    private func setupConstrains() {
        let safeArie = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            castomView.topAnchor.constraint(equalTo: safeArie.topAnchor),
            castomView.leadingAnchor.constraint(equalTo: safeArie.leadingAnchor),
            castomView.trailingAnchor.constraint(equalTo: safeArie.trailingAnchor),
            castomView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            
            avatarImage.leftAnchor.constraint(equalTo: safeArie.leftAnchor, constant: 16),
            avatarImage.widthAnchor.constraint(equalToConstant: 100),
            avatarImage.topAnchor.constraint(equalTo: safeArie.topAnchor, constant: 16),
            avatarImage.heightAnchor.constraint(equalToConstant: 100),
            
            //nameLabel.topAnchor.constraint(equalTo: safeArie.topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 15),
            
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -8),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 15),
            
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -16),
            statusTextField.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 15),
            statusTextField.rightAnchor.constraint(equalTo: safeArie.rightAnchor, constant: -16),
            
            button.leadingAnchor.constraint(equalTo: safeArie.leadingAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: safeArie.rightAnchor, constant: -16),
            button.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 34),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            closeImageButton.topAnchor.constraint(equalTo: castomView.topAnchor, constant: 16),
            closeImageButton.trailingAnchor.constraint(equalTo: castomView.trailingAnchor, constant: -16),
            closeImageButton.heightAnchor.constraint(equalToConstant: 50),
            closeImageButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Gesture/animation
    
    private func setupGesture() {
        let gest = UITapGestureRecognizer()
        gest.addTarget(self, action: #selector(animateAvatar))
        avatarImage.addGestureRecognizer(gest)
    }
    
    @objc private func animateAvatar() {
        imagePosition = avatarImage.layer.position
        imageBounds = avatarImage.layer.bounds
        
        let centerScreen = UIScreen.main.bounds.height / 2  - avatarImage.bounds.height
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseInOut) { [self] in
            castomView.alpha = 0.7
            statusLabel.alpha = 0.3
            statusTextField.alpha = 0.3
            button.alpha = 0.3
            self.avatarImage.center.y = centerScreen
            self.avatarImage.center.x = castomView.center.x
            self.avatarImage.layer.cornerRadius = 0
            self.avatarImage.layer.borderWidth = 0.1
            self.avatarImage.layer.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0.0) {
                self.layoutIfNeeded()
                self.closeImageButton.alpha = 1
            }
            
        }
        
    }
    
    @objc private func closeImageAction() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseInOut) {
            self.castomView.alpha = 0
            self.statusLabel.alpha = 1
            self.statusTextField.alpha = 1
            self.button.alpha = 1
            
            self.avatarImage.layer.position = self.imagePosition
            self.avatarImage.layer.bounds = self.imageBounds
            self.avatarImage.layer.cornerRadius = self.avatarImage.bounds.width / 2
            self.closeImageButton.alpha = 0
        }
    }
    
    
    //MARK: - Actions
    
    
    @objc private func statusTextChanged() {
        if let text = statusTextField.text {
            statusLabel.text = text
        }
        
    }
    
}

