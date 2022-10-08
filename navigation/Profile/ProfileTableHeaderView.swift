
import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    private lazy var avatarImage: UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "avatar.jpg")
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 50
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.isAccessibilityElement = true
        avatar.accessibilityLabel = "avatar"
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        return avatar
    }()
    
    private lazy var  nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Angoric"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let status = UILabel()
        status.text = "У меня лапки!"
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = UIColor.gray
        status.backgroundColor = .white
        status.translatesAutoresizingMaskIntoConstraints = false
        
        return status
    }()
    
    private lazy var button :UIButton = {
        let btn = UIButton()
        btn.setTitle("Show status", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 14
        btn.layer.shadowRadius = 4
        btn.layer.shadowOffset.width = 4
        btn.layer.shadowOffset.height = 4
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.7
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(printStatus), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.textColor = UIColor.black
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderWidth = 1.0
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    @objc func printStatus() {
        if let text = statusLabel.text {
            print(text)
        }
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: nil)
        setupView()
        setupConstrains()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.addSubview(button)
        self.addSubview(nameLabel)
        self.addSubview(avatarImage)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
    }
    
    func setupConstrains() {
        let safeArie = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            avatarImage.leftAnchor.constraint(equalTo: safeArie.leftAnchor, constant: 16.0),
            avatarImage.widthAnchor.constraint(equalToConstant: 100.0),
            avatarImage.topAnchor.constraint(equalTo: safeArie.topAnchor, constant: 16.0),
            avatarImage.heightAnchor.constraint(equalToConstant: 100.0),
            
            //nameLabel.topAnchor.constraint(equalTo: safeArie.topAnchor, constant: 30.0 ),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 15.0),
            
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -8.0),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 15.0),
            
            statusTextField.heightAnchor.constraint(equalToConstant: 40.0),
            statusTextField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -16.0),
            statusTextField.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 15),
            statusTextField.rightAnchor.constraint(equalTo: safeArie.rightAnchor, constant: -16.0),
            
            button.leadingAnchor.constraint(equalTo: safeArie.leadingAnchor, constant: 16.0),
            button.rightAnchor.constraint(equalTo: safeArie.rightAnchor, constant: -16.0),
            button.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 34.0),
            button.heightAnchor.constraint(equalToConstant: 50.0),
        ])
    }
    
    @objc func statusTextChanged() {
        if let text = statusTextField.text {
            statusLabel.text = text
        }
    }
}

